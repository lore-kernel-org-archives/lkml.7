Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50285C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EFB21530
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfFSMSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:18:54 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:57209 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfFSMSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:18:53 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9965320025;
        Wed, 19 Jun 2019 14:18:47 +0200 (CEST)
Date:   Wed, 19 Jun 2019 14:18:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v5 1/2] dt-bindings: Add doc for the Ingenic JZ47xx LCD
 controller driver
Message-ID: <20190619121846.GA29084@ravnborg.org>
References: <20190603152331.23160-1-paul@crapouillou.net>
 <20190611215554.GA23791@bogus>
 <1560329392.1823.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560329392.1823.1@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=VwQbUJbxAAAA:8
        a=ER_8r6IbAAAA:8 a=p6pI0oa4AAAA:8 a=GHe269Cog9DItrN4tF0A:9
        a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=9LHmKk7ezEChjTCyhBa9:22
        a=9cw2y2bKwytFd151gpuR:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 10:49:52AM +0200, Paul Cercueil wrote:
> 
> 
> Le mar. 11 juin 2019 à 23:55, Rob Herring <robh@kernel.org> a écrit :
> > On Mon,  3 Jun 2019 17:23:30 +0200, Paul Cercueil wrote:
> > >  Add documentation for the devicetree bindings of the LCD controller
> > > present in
> > >  the JZ47xx family of SoCs from Ingenic.
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  Tested-by: Artur Rojek <contact@artur-rojek.eu>
> > >  ---
> > > 
> > >  Notes:
> > >      v2: Remove ingenic,panel property.
> > > 
> > >      v3: - Rename compatible strings from ingenic,jz47XX-drm to
> > > ingenic,jz47XX-lcd
> > >          - The ingenic,lcd-mode property is now read from the panel
> > > node instead
> > >      	  of from the driver node
> > > 
> > >      v4: Remove ingenic,lcd-mode property completely.
> > > 
> > >      v5: No change
> > > 
> > >   .../bindings/display/ingenic,lcd.txt          | 44
> > > +++++++++++++++++++
> > >   1 file changed, 44 insertions(+)
> > >   create mode 100644
> > > Documentation/devicetree/bindings/display/ingenic,lcd.txt
> > > 
> > 
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> > 
> > If a tag was not added on purpose, please state why and what changed.
> 
> Sorry Rob, my mistake. I simply forgot that you ever reviewed that patch.
Added Rob's r-b and pushed to drm-misc-next

	Sam
