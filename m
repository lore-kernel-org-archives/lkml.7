Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AD7C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF7020857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCBRUj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 12:20:39 -0500
Received: from mail-oln040092070015.outbound.protection.outlook.com ([40.92.70.15]:29754
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbfCBRUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 12:20:38 -0500
Received: from DB5EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (10.152.20.55) by DB5EUR03HT093.eop-EUR03.prod.protection.outlook.com
 (10.152.21.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.11; Sat, 2 Mar
 2019 17:20:34 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.20.59) by
 DB5EUR03FT007.mail.protection.outlook.com (10.152.20.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.11 via Frontend Transport; Sat, 2 Mar 2019 17:20:34 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3%10]) with mapi id 15.20.1665.015; Sat, 2 Mar 2019
 17:20:33 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
Thread-Topic: [PATCH v3 2/2] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
Thread-Index: AQHUxucMoxU67kG9/EyxObajZ+kTbqX4eAaAgAAypAA=
Date:   Sat, 2 Mar 2019 17:20:33 +0000
Message-ID: <AM3PR03MB0966F2308C6003C192A68F4DAC770@AM3PR03MB0966.eurprd03.prod.outlook.com>
References: <20190217173407.29189-1-katsuhiro@katsuster.net>
 <20190217173407.29189-2-katsuhiro@katsuster.net>
 <d42dd768-d6c1-098d-759f-e3576d0edcc2@katsuster.net>
In-Reply-To: <d42dd768-d6c1-098d-759f-e3576d0edcc2@katsuster.net>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0043.eurprd09.prod.outlook.com
 (2603:10a6:7:15::32) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:B4E8430D749EE469649883135F264C20922E0D0FA43BAFF6F1E87B268EFF9507;UpperCasedChecksum:F1A336DCFFBA3EF2E599F690CB35DDF105B3AE27220B3B3E08C2E12C3691FC61;SizeAsReceived:7834;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [+hqndVKGM9qvdoOWFsq9qdG3xJA17iNh]
x-microsoft-original-message-id: <bf12555f-380c-0504-3b10-fa50ac30a8ee@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:DB5EUR03HT093;
x-ms-traffictypediagnostic: DB5EUR03HT093:
x-microsoft-antispam-message-info: QAvaa5wEt0p9ARoQBfmXxOUg/fspG18SZKi0svY/RADUvqT/K7bEzgAp9zr9pp3u
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A0F9C4F8C1C22F47BDE8C72A026A0DA5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c4abaf-729d-482e-f8aa-08d69f33608c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2019 17:20:33.6858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-02 15:19, Katsuhiro Suzuki wrote:
> Ping...
>
> On 2019/02/18 2:34, Katsuhiro Suzuki wrote:
>> This patch adds HDMI sound (I2S0) node for rock64.
>>
>> After apply this patch, UART2 will fail to allocate DMA resources
>> but UART driver can work fine without DMA.
>>
>> This error is related to the DMAC of rk3328 (pl330 or compatible).
>> DMAC connected to 16 DMA sources. Each sources have ID number that is
>> called 'Req number' in rk3328 TRM. Currently total 7 sources has been
>> activated as follows:
>>
>> | Req number | Source | Required  |
>> |            |        | channels  |
>> |------------+--------+-----------|
>> | 14, 15     | I2S1   | 2ch       |
>> |  6,  7     | UART2  | 2ch       |
>> |     10     | SPDIF  | 1ch       |
>> |  8,  9     | SPI0   | 2ch       |
>> |------------+--------+-----------|
>> |            | Total  | 7ch       |
>>
>> HDMI audio needs to activate new source I2S0 (Req number 11 and 12).
>> I2S0 can work concurrently with other sources, but rk3328 DMAC can
>> use max 8 channels at same time. If I2S0 is simply activated by this
>> patch, required DMAC channels will be 9. So last one (UART2) cannot
>> allocate the DMA resources.
>>
>> Virt-dma mechanism for pl0330 DMAC driver is needed to fix this
>> problem.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 21 ++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> index 2157a528276b..bfc0930d245c 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> @@ -68,7 +68,8 @@
>>   	sound {
>>   		compatible = "audio-graph-card";
>>   		label = "rockchip,rk3328";
>> -		dais = <&i2s1_p0
>> +		dais = <&i2s0_p0
>> +			&i2s1_p0
>>   			&spdif_p0>;

I am working on multi-channel hdmi audio support for dw-hdmi at [1] and are wondering if having multiple dais on one graph card
instead of a separate hdmi sound card will affect the ability to define a proper alsa config for multi channel hdmi sound.

[1] https://github.com/Kwiboo/linux-rockchip/compare/8874c206d613dc575f5cb6e385e7a866020138d0...92b20eaa6b6dd2cf3418a428f905d10bbc62724f

Regards,
Jonas

>>   	};
>>   
>> @@ -141,6 +142,12 @@
>>   
>>   &hdmi {
>>   	status = "okay";
>> +
>> +	port@0 {
>> +		hdmi_p0_0: endpoint {
>> +			remote-endpoint = <&i2s0_p0_0>;
>> +		};
>> +	};
>>   };
>>   
>>   &hdmiphy {
>> @@ -256,6 +263,18 @@
>>   	};
>>   };
>>   
>> +&i2s0 {
>> +	status = "okay";
>> +
>> +	i2s0_p0: port {
>> +		i2s0_p0_0: endpoint {
>> +			dai-format = "i2s";
>> +			mclk-fs = <256>;
>> +			remote-endpoint = <&hdmi_p0_0>;
>> +		};
>> +	};
>> +};
>> +
>>   &i2s1 {
>>   	status = "okay";
>>   
>>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> https://nam03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-rockchip&amp;data=02%7C01%7C%7Cfcb0d6c43ded4d5e7d4c08d69f1a226d%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C636871331922090426&amp;sdata=ABb%2Fo%2FMAGvFBH%2B37uQr6rzn%2B%2FXBAXyiGfv2%2BMO0RQoQ%3D&amp;reserved=0

