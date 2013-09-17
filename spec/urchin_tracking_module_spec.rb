# Urchin Tracking Module
require 'urchin_tracking_module'
require 'uri'
require 'spec_helper'

describe UrchinTrackingModule do
  Utm = UrchinTrackingModule
  let(:params) {{}}
  let(:url) { 'http://example.com?src=fba_blooming/#/shops' }
  subject { Utm.new(url) }

  context 'basic tracking' do
    let(:params) {{
        utm_source: 'transactional_emails',
        utm_medium: 'email',
        utm_term:   'electronics',
        utm_content: 'variant_guy',
        utm_campaign: 'xmas_2013' }}

    Utm::TRACKING_PARAMETERS.each do |tracking_param|
      it "tracks #{tracking_param}" do
        uri = subject.tracking(params)
        expect(uri).to match(/#{tracking_param}=#{params[tracking_param]}/)
      end
    end
  end

  describe '.configure' do
    EXAMPLE_CONFIG = {
      utm_source:   'b2b_application',
      utm_medium:   'banner300',
      utm_term:     'fashion',
      utm_content:  'luxury_goods',
      utm_campaign: 'spring_2014'
    }

    EXAMPLE_CONFIG.each do |(name,value)|
      it "configures #{name}" do
        Utm.configure { |utm| utm[name]= value }
        expect(subject.tracking).to match(/#{name}=#{value}/)
      end
    end

    it 'configures src' do
      # checking for side effects and overrides
      Utm.configure { |utm| utm[:utm_source]= 'funnel_source_for_bi' }
      expect(subject.tracking).to match(/src=funnel_source_for_bi/)
      expect(UTM(url, utm_source: 'pewpew')).to match(/src=pewpew/)
      expect(UTM(url, utm_source: 'pewpew')).to match(/utm_source=pewpew/)
      expect(subject.tracking).not_to match(/src=fba_blooming/)
      expect(subject.tracking).to match(/utm_source=funnel_source_for_bi/)
    end
  end

  it 'configures Utm.source' do
    Utm.configure { |utm| utm[:utm_source]= EXAMPLE_CONFIG[:utm_source] }
    expect(Utm.source).to eq EXAMPLE_CONFIG[:utm_source]
  end

  it 'configures Utm.medium' do
    Utm.configure { |utm| utm[:utm_medium]= EXAMPLE_CONFIG[:utm_medium] }
    expect(Utm.medium).to eq EXAMPLE_CONFIG[:utm_medium]
  end

  describe 'UTM helper' do
    let(:utm) { double }

    it 'invokes Utm' do
      Utm.should_receive(:new).with(url).and_return(utm)
      utm.should_receive(:tracking).with(params)
      UTM(url,params)
    end
  end
end
