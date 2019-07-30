Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7BFC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED08720651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfG3OKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:10:12 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48202 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbfG3OKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:10:12 -0400
Received: from [167.98.27.226] (helo=[10.35.6.253])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hsSpF-0006wT-83; Tue, 30 Jul 2019 15:10:01 +0100
Subject: Re: [alsa-devel] [PATCH v2 1/3] dt-bindings: ASoC: Add TDA7802
 amplifier
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Marco Felsch <m.felsch@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, Nate Case <ncase@tesla.com>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Rob Duncan <rduncan@tesla.com>,
        Patrick Glaser <pglaser@tesla.com>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-2-thomas.preston@codethink.co.uk>
 <20190730122748.GF54126@ediswmail.ad.cirrus.com>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <16dff5b4-6a94-42de-85d4-0f4ec01fac8c@codethink.co.uk>
Date:   Tue, 30 Jul 2019 15:10:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730122748.GF54126@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2019 13:27, Charles Keepax wrote:
> On Tue, Jul 30, 2019 at 01:09:35PM +0100, Thomas Preston wrote:
>> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
>> Cc: Patrick Glaser <pglaser@tesla.com>
>> Cc: Rob Duncan <rduncan@tesla.com>
>> Cc: Nate Case <ncase@tesla.com>
>> ---
>>  .../devicetree/bindings/sound/tda7802.txt     | 26 +++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/tda7802.txt b/Documentation/devicetree/bindings/sound/tda7802.txt
>> new file mode 100644
>> index 000000000000..f80aaf4f1ba0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/tda7802.txt
>> @@ -0,0 +1,26 @@
>> +ST TDA7802 audio processor
>> +
>> +This device supports I2C only.
>> +
>> +Required properties:
>> +
>> +- compatible : "st,tda7802"
>> +- reg : the I2C address of the device
>> +- enable-supply : a regulator spec for the PLLen pin
>> +
>> +Optional properties:
>> +
>> +- st,gain-ch13 : gain for channels 1 and 3 (range: 1-4)
>> +- st,gain-ch24 : gain for channels 2 and 3 (range: 1-4)
> 
> I wouldn't have expected the gains to be available as a device
> tree setting.
> 

Ah, I forgot to update the docs from v1. Thanks
