Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAE5C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08082086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfHJTkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 15:40:33 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:51497 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbfHJTkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:40:33 -0400
Received: from xps13 ([83.160.161.190])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id wXDwhDdUKur8TwXDzheXm4; Sat, 10 Aug 2019 21:40:30 +0200
Message-ID: <21cc0cf51c67e708eb7a4d59702a04bc025b3b2f.camel@tiscali.nl>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Jose Souza <jose.souza@intel.com>
Cc:     James.Bottomley@HansenPartnership.com,
        intel-gfx@lists.freedesktop.org, chris@chris-wilson.co.uk,
        linux-kernel@vger.kernel.org
Date:   Sat, 10 Aug 2019 21:40:20 +0200
In-Reply-To: <54f0979debcd4459ca9d9f25941d4fa29a1aab06.camel@intel.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
         <1562875878.2840.0.camel@HansenPartnership.com>
         <27a5b2ca8cfc79bf617387a363ea7192acc4e1f0.camel@intel.com>
         <1562876880.2840.12.camel@HansenPartnership.com>
         <1562882235.13723.1.camel@HansenPartnership.com>
         <dad073fb4b06cf0abb7ab702a9474b9c443186eb.camel@intel.com>
         <1562884722.15001.3.camel@HansenPartnership.com>
         <2c4edfabf49998eb5da3a6adcabc006eb64bfe90.camel@tiscali.nl>
         <55f4d1c242d684ca2742e8c14613d810a9ee9504.camel@intel.com>
         <1562888433.2915.0.camel@HansenPartnership.com>
         <1562941185.3398.1.camel@HansenPartnership.com>
         <68472c5f390731e170221809a12d88cb3bc6460e.camel@tiscali.nl>
         <143142cad4a946361a0bf285b6f1701c81096c7b.camel@intel.com>
         <595d9bc87bf47717c8675eb5b1a1cbb2bc463752.camel@tiscali.nl>
         <a10f009fc160f05077760ff59cd86a9c99006b39.camel@intel.com>
         <9ef8fc1ae2c3a9bad588899488a781333af4449a.camel@tiscali.nl>
         <1563398966.3438.5.camel@HansenPartnership.com>
         <b22cf290b089cb1174ec0fdeb15bdf2e90bf51dc.camel@tiscali.nl>
         <d084df248afc1943e06c50d391a775d117064743.camel@intel.com>
         <df4d83e5c5650ea2f1afde1469c9dc82d6120644.camel@tiscali.nl>
         <54f0979debcd4459ca9d9f25941d4fa29a1aab06.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMaosohlSnRSuBLjzIqy8RaAwYjeIfJz8jhc2d/SNfuXG4SsfLGK+kBbz7W8ZCx+jd1G96h9pRe8+yGwaL1QVAEqliMOeOcuX63i+gk/JUvNhwbOGDiX
 OGwFm9l6Q+sSyDZtCvrL4Tisuy4bpyGszcQRzFNrAttUNpPhoKf9JaIvGOxbDbqgm4iwd14emAbjTzmpdwf7CCLeHV8bjIc8JxaLV9+uOSynRaY3et8nHtrz
 yYoE5Z6AD4WlJLN+BGrLWPfEAeMInp2CY4Vm5AqrHGIiBbexeiuOb/1ekQNN5Cdefv4ACPnlP+AXC/9FGmiosMGSmAVifAq03jrO3pHwEXU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Souza, Jose schreef op vr 09-08-2019 om 17:16 [+0000]:
> Fix released on Linux 5.2.8

Linux 5.2.8 doesn't have the pretty obvious freezes so this fix works for me
too. Thanks for letting me know!


Paul Bolle

