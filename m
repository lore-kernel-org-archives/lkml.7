Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84681C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B73D22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="a/RfKNL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfH1NC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:02:59 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:48198 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfH1NC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:02:58 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46JQq06pXgz86;
        Wed, 28 Aug 2019 15:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566997278; bh=uRuZuOqBLbzAnAvpCnYbVSyoMKxEZTSKinbvSRrThOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/RfKNL4MlNT+Kbj4nC71eLuYccZ4AB8NolM7w1vrgnZ6euiuqXjf13U1jRziElvk
         ucg3Gg+i24xGI5+y1w5iJegO715BAu/bLNhxEYNUKzEy6OQXtqJW8PlZZLqWxHCTy4
         8qf92eDmWNSZVcDwKReB5AdAirysbTx9mkKGrZ//GDRi2JU3P3EDBMYwdZ07NY2iAm
         sVVtEL3HNSEPj102qGv/PBH+OnPi+Z2ZaumQOHIcsWDtMAYXYi0UtlKXLx/uy9mxnb
         dS34IGGFYSRXIGcA+3LpGRzW4Vtz9OcFeuOjTe0qX65wYYLZUBDaRyaQvhUTOE2LC8
         a+nZHriRfnmcA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Wed, 28 Aug 2019 15:02:52 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chas Williams <3chas3@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: misc: atmel-ssc: LRCLK from TF/RF
 pin option
Message-ID: <20190828130252.GD20202@qmqm.qmqm.pl>
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl>
 <9b85d5a7c7e788e9ed87d020323ad9292e3aeab7.1566677788.git.mirq-linux@rere.qmqm.pl>
 <20190827223716.GA31605@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827223716.GA31605@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 05:37:16PM -0500, Rob Herring wrote:
> On Sat, Aug 24, 2019 at 10:26:55PM +0200, Micha³ Miros³aw wrote:
> > Add single-pin LRCLK source options for Atmel SSC module.
> > 
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > 
> > ---
> >   v2: split from implementation patch
> > 
> > ---
> >  Documentation/devicetree/bindings/misc/atmel-ssc.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> > index f9fb412642fe..c98e96dbec3a 100644
> > --- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> > +++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> > @@ -24,6 +24,11 @@ Optional properties:
> >         this parameter to choose where the clock from.
> >       - By default the clock is from TK pin, if the clock from RK pin, this
> >         property is needed.
> > +  - atmel,lrclk-from-tf-pin: bool property.
> > +  - atmel,lrclk-from-rf-pin: bool property.
> > +     - SSC in slave mode gets LRCLK from RF for receive and TF for transmit
> > +       data direction. This property makes both use single TF (or RF) pin
> > +       as LRCLK. At most one can be present.
> 
> A single property taking 1 of possible 2 values would prevent the error 
> of more than 1 property present.

It still would need a validation check in the code, though: you
could put wrong value then.  It seems more consistent with the
existing parameters to have two bool properties.

Best Regards,
Micha³ Miros³aw
