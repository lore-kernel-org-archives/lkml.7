Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD61C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B802084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HgYwt1gE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T/MVcH8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfDIOtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:49:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54636 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:49:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D2ED060FE9; Tue,  9 Apr 2019 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554821338;
        bh=vpTvSs6wcW4crrqRvD1y8F8iRUJI7sBn/vsrNUENmho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HgYwt1gEeFkTBEj011SfeuWvj/BQAyEPSScSCswX7c6qM8MEBUX0rD7MLmDdsVxL0
         FV6xbUI+8OQI8yl8QBE/QivHfFaQtLpZr/zuYlqEspwPFgvMWNhhqB/RWgs/+XcA3b
         SzHFZS+LKXqzOKQVaE1y51s93qTZQAFZtRs+EQgE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A4D3760E5A;
        Tue,  9 Apr 2019 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554821337;
        bh=vpTvSs6wcW4crrqRvD1y8F8iRUJI7sBn/vsrNUENmho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T/MVcH8LLDtFM6QwiZ4Wyjg1gc0LRzTq7WCQW6ZdxNHcrTykvQgCztu6tVXlmqVST
         0aBn7svfXs/rTQ2kzDPfioThcBykLiSuY0LLyTlhV7J6Qcv8xwxlqC5kpkZQPD6DS6
         1nPJmsWvOITJKW/xwkw8BG8ckuO1bXd9CPmc/0vc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Apr 2019 22:48:57 +0800
From:   Rocky Liao <rjliao@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: net: bluetooth: Add device property
 nvm-postfix for QCA6174
In-Reply-To: <CAL_JsqKLL8x63wzpi2tfNfvVe5TX=Uxz+owPZbhevhW-84bDAA@mail.gmail.com>
References: <1554359858-21049-1-git-send-email-rjliao@codeaurora.org>
 <1554368908-22017-1-git-send-email-rjliao@codeaurora.org>
 <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
 <535c74d4-00b1-eef2-578a-8807f4b9f640@free.fr>
 <319cbb5f23ed3d9f1ae77c697001378d@codeaurora.org>
 <CAL_JsqKLL8x63wzpi2tfNfvVe5TX=Uxz+owPZbhevhW-84bDAA@mail.gmail.com>
Message-ID: <b7afb25fe2ce759281f1a887df95e71f@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-09 22:03, Rob Herring wrote:
> On Tue, Apr 9, 2019 at 5:15 AM Rocky Liao <rjliao@codeaurora.org> 
> wrote:
>> 
>> On 2019-04-04 20:32, Marc Gonzalez wrote:
>> > +robh
>> >
>> > On 04/04/2019 11:08, Rocky Liao wrote:
>> >
>> >> This patchs patch adds an optional device property nvm-postfix to
>> >> allow the
>> >> driver to load customized nvm file based on this property
>> >
>> > While text /before/ is indeed called a "prefix", text /after/ is not a
>> > "postfix",
>> > but a "suffix".
>> >
>> >
>> >>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >>
>> >> diff --git
>> >> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> >> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> >> index 824c0e2..70cda4b 100644
>> >> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> >> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> >> @@ -16,6 +16,7 @@ Optional properties for compatible string
>> >> qcom,qca6174-bt:
>> >>
>> >>   - enable-gpios: gpio specifier used to enable chip
>> >>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>> >> + - nvm-postfix: nvm file postfix to load customized nvm file
>> >
>> > The device tree is supposed to describe hardware.
>> >
>> > The name of which file to load can hardly be considered part of the HW.
>> >
>> > Possible solutions:
>> > 1) derive the file name from the compatible string
>> > 2) pass the name as a module parameter
>> > 3) something else
>> >
>> >
>> >> @@ -39,6 +40,7 @@ serial@7570000 {
>> >>
>> >>              enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
>> >>              clocks = <&divclk4>;
>> >> +            nvm-postfix = "i2s";
>> >>      };
>> >>  };
>> >
>> > If one provides the entire suffix, including the underscore, then you
>> > can
>> > simplify the code:
>> >
>> >       snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x%s.bin",
>> > soc_ver, suffix ? suffix : "");
>> >
>> > Regards
>> .
>> Hi Marc,
>> 
>> The major purpose for that property is about the BT audio bus type, 
>> can
>> it be considered as part of the HW? If yes maybe we can use a property
>> name "audio-bus" to reflect that.
>> 
>> If not then I will adopt the solution 1 to add a new compatible string
>> "{ .compatible = "qcom,qca6174-bt-i2s" }" and load specific nvm for 
>> this
>> compatible string, please feel free to let me know if any other
>> concerns.
> 
> I don't think the suggestion was to add the nvm string to the
> compatible, but rather compatible strings serve as a map key. Having
> board specific firmware files for wifi/bt is pretty common, but
> parameters for 'i2s' is a bit strange. So a better explanation of what
> parameters this contains would help. How/when does it vary, for
> example?
> 
> Also, if it is only a handful of parameters, making them DT properties
> is preferred.
> 
> Rob

Ok, I prefer to go with adding a device property "firmware-name" with 
full firmware name as you suggested in previous comment.
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
