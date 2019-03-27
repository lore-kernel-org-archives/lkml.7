Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2336CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1EA206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lvq/JFqV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Igm8JCgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbfC0KYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:24:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0KYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:24:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3FA7B60DA8; Wed, 27 Mar 2019 10:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553682246;
        bh=r+1Lj/7MrgW05+FCDVNp7GEIacam5lVfaHrQ6u4EWw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lvq/JFqVl8qZjEbQpn0EGp7qm4ZzFpbrRzDfjS4IJJXyaNdD2/1PkQ6vNlzQ7eME6
         WD3IS2m6qWy9N5spKy6d+bbjQDE9aNI4QCPlz5sjuDFb03GaRLONdfoikXcZrNZ79k
         Lq0QBIvPUYEJOMnnwNdnw1nmnBM0/kFZTaE6p7cs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id EFBBF60F38;
        Wed, 27 Mar 2019 10:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553682240;
        bh=r+1Lj/7MrgW05+FCDVNp7GEIacam5lVfaHrQ6u4EWw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Igm8JCgy0ZFdA3diPl9Rp+Q8UcmEp+gLfy0BJtpMJuu4na/5xwJidQb+ETdspoxSh
         K1HVqiMcwWvDY1PbXahKcqukmdJ7gsQMDoYmbymP2EgTN9arcCdYsAXMerK5vpzMwF
         NdYc0LPDEbRxJ8vcUJ15x76cnvXw4nxWQyujHpEI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 27 Mar 2019 15:53:58 +0530
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-bluetooth-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3998
In-Reply-To: <20190326235458.GA112750@google.com>
References: <1552393379-26330-1-git-send-email-c-hbandi@codeaurora.org>
 <1552393379-26330-3-git-send-email-c-hbandi@codeaurora.org>
 <20190312165928.GD200579@google.com>
 <88a923e02073461abb5f3a7674150615@codeaurora.org>
 <20190314185637.GB112750@google.com>
 <8432d8b9743e2b4b6a7195329c808af3@codeaurora.org>
 <20190326235458.GA112750@google.com>
Message-ID: <6a57b6cfd92f982c5e00fc1db30e778e@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-03-27 05:24, Matthias Kaehlcke wrote:
> On Mon, Mar 25, 2019 at 05:00:31PM +0530, c-hbandi@codeaurora.org 
> wrote:
>> Hi Matthias,
>> 
>>  On 2019-03-15 00:26, Matthias Kaehlcke wrote:
>> > Hi Harish,
>> >
>> > On Wed, Mar 13, 2019 at 12:00:06PM +0530, c-hbandi@codeaurora.org wrote:
>> > > Hi Matthias,
>> > >
>> > >
>> > > On 2019-03-12 22:29, Matthias Kaehlcke wrote:
>> > > > +DT folks
>> > > >
>> > > > Please add them in future versions (script/scripts/get_maintainer.pl
>> > > > <patches> should have listed them)
>> > >
>> > > [Harish] -- Will add them in new version of patches.
>> > > >
>> > > > On Tue, Mar 12, 2019 at 05:52:59PM +0530, Harish Bandi wrote:
>> > > > > This patch enables regulators for the Qualcomm Bluetooth wcn3998
>> > > > > controller.
>> > > >
>> > > > No, it doesn't.
>> > > >
>> > > > The next version should probably say something like "Add compatible
>> > > > string for the Qualcomm WCN3998 Bluetooth controller.
>> > > >
>> > > [Harish] -- From new patch onwards will add all patch
>> > > version changes and add proper description.
>> > >
>> > > > Is there any particular reason why QCA drivers folks use 'wcn' instead
>> > > > of 'WCN'? The QCA documentations calls it WCN399x, so I'd suggest to
>> > > > consistently use the uppercase name in comments and documentation (and
>> > > > log messages?).
>> > > >
>> > > [Harish] -- I think in DT we need to have small case like wcn,
>> >
>> > agreed
>> >
>> > > i think that is the reason it started using in code, comments and dt
>> > > documentation.
>> >
>> > AFAIK there are no hard rules for everything, my suggestion would be:
>> >
>> > - use WCN399x
>> >   - for general comments/documentation
>> >   - commit messages
>> >   - in DT context wcn3998-n seems ok
>> > - use wcn399x
>> >   - for function and variable names
>> >   - for compatible strings
>> >
>> > For logging: whatever, just be consistent.
>> 
>>  [Harish] --For Commit messages and all will try to follow change it 
>> new
>> patch
>> 
>> >
>> > > > > Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
>> > > > > ---
>> > > > > changes in v3:
>> > > > > - updated to latest code base.
>> > > >
>> > > > This comment is useless, please describe what changed wrt the previous
>> > > > version.
>> > > [Harish] --  added details in v2, and v3 uploaded just to rebase on
>> > > tip of
>> > > bluetooth-next
>> > > for better understanding of code in review. From new patch onwards
>> > > will add
>> > > all patch
>> > > version changes and add proper description.
>> > > >
>> > > > > ---
>> > > > >  .../devicetree/bindings/net/qualcomm-bluetooth.txt        | 15
>> > > > > +++++++++++++++
>> > > > >  1 file changed, 15 insertions(+)
>> > > > >
>> > > > > diff --git
>> > > > > a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> > > > > b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> > > > > index 824c0e2..1221535 100644
>> > > > > --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> > > > > +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
>> > > > > @@ -53,3 +53,18 @@ serial@898000 {
>> > > > >  		max-speed = <3200000>;
>> > > > >  	};
>> > > > >  };
>> > > > > +
>> > > > > +&blsp1_uart3 {
>> > > > > +	pinctrl-names = "default";
>> > > > > +	pinctrl-0 = <&blsp1_uart3_default>;
>> > > > > +	status = "okay";
>> > > > > +
>> > > > > +	bluetooth: wcn3998-bt {
>> > > > > +		compatible = "qcom,wcn3998-bt";
>> > > > > +		vddio-supply = <&vreg_l6_1p8>;
>> > > > > +		vddxo-supply = <&vreg_l5_1p8>;
>> > > > > +		vddrf-supply = <&vreg_s5_1p35>;
>> > > > > +		vddch0-supply = <&vdd_ch0_3p3>;
>> > > > > +		max-speed = <3200000>;
>> > > > > +	};
>> > > > > +};
>> > > > > \ No newline at end of file
>> > > >
>> > > > I think the example isn't really needed since it's essentially the
>> > > > same as the one for 'qcom,wcn3990-bt'.
>> > > >
>> > > > But the important part is missing: add the new compatible string under
>> > > > ´Required properties´. You also want to update the documentation that
>> > > > mentiones 'qcom,wcn3990-bt' to 'qcom,wcn399x-bt' (assuming for now
>> > > > that other possible WCN399x chips would be similar).
>> > > >
>> > > [Harish] -- Will check the DT properties, documentation and update
>> > > accordingly in new patch.
>> > >
>> > > > You mentioned in an earlier version of the series that there are
>> > > > multiple WCN3998 variants with different requirements for
>> > > > voltage/current. This seems to suggests that multiple compatible
>> > > > strings are needed to distinguish between them.
>> > > >
>> > > [Harish] -- for now we want to add WCN3998 support only, What i mean
>> > > to say
>> > > in my earlier
>> > > explanation that. WCN3990 is base variant and on top of that we have
>> > > variants like WCN3990,
>> > > WCN3998 and WCN3998-0,WCN3998-1 like that..
>> > > So I think wcn399x would make sense for this series.
>> >
>> > If the variants have relevant differences between them (like different
>> > regulator requirements) I think you want unique names, rather than
>> > 'wcn399x' (I was referring to comments/documentation with this
>> > string).
>> >
>> > If there are variants wouldn't your first 'wcn3998' already be a
>> > 'wcn3998-n'? If 'wcn3998' without suffix is used I think it needs to
>> > be valid for all 'wcn3998-n' variants (it might be less
>> > power-efficient though than using the variant specific compatible
>> > string), otherwise things get confusing (a 'wcn3998-2' isn't a
>> > 'wcn3998'?)
>> >
>> 
>> 
>>  [Harish] -- for now WCN3990 and WCN3998 only, also wcn3998-2 and 
>> wcn3998
>> are same.
>> So for now we are going to have only WCN3990 and WCN3998 for DT.
> 
> Since you brought up the different power requirements initially:
> 
> are your reasonably sure that future wcn3998-3, wcn3998-4, ... can
> operate with the generic wcn3998 power settings?

[Harish] - yes with power settings of wcn3998, wcn3998-3 and wcn3998-4 
... also will work.
