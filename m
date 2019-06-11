Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869D6C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0A1212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560243747;
	bh=fQvk63fA1j2fIYD441wZXyOy9D77ndc0tTK2OqRZRJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uy773eHO/5o6J+gHyT9O+e2A5zYGliNtt+XLgc7z9dHb6HJCGLgvoZKf1HsklvGrN
	 XJCNZLVVWySxNIwAgU45JMhNKN8y/Y4bfkDEyxlGCko+afkpcI+2bhJr99X1i83AJ+
	 NjTnJ4TYWj4DQ09omJ4hlfebtlWbVTr+tgw+5I1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404859AbfFKJC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:02:26 -0400
Received: from casper.infradead.org ([85.118.1.10]:45176 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404175AbfFKJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PGE5VqFfULoj6KOhNC2Wh389GnvDk39/aZQXFDTbc2w=; b=PrXM+LKqTkZz/A8Cj77jfHhVnl
        zfQz/kM3Athwcai0W/Elw8sxuzvTnaxayq78V+OBesZRgSxkgCWNpIF4TPcsBUJp2/MrJwIC8LVmP
        HSwpd2Nef0IlerjBu2Ynz3JHD62kkHTECNOMmIVXRdQM/Kedp4C2Ps5VUbbsl4NvicrYMeKSFNbw0
        TcAXKSgjzvNUWS8hYviQjzRw77J5ATDYE1hPT2gc34/eUqMZNmOhd260tP2HN1jdIN+CndfsoJOy3
        0GU3JjRXDw5l2+LGkwY/+VR8zSF7l+x6mQR3UI6gYLnIcuC2g0m/ML7lFHTweQUZ2dMZaRmkM9Qxp
        IG4/l4uA==;
Received: from 177.41.119.178.dynamic.adsl.gvt.net.br ([177.41.119.178] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hacfd-00058m-Id; Tue, 11 Jun 2019 09:02:22 +0000
Date:   Tue, 11 Jun 2019 06:02:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 33/33] docs: EDID/HOWTO.txt: convert it and rename to
 howto.rst
Message-ID: <20190611060215.232af2bb@coco.lan>
In-Reply-To: <20190611083731.GS21222@phenom.ffwll.local>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
        <74bec0b5b7c32c8d84adbaf9ff208803475198e5.1560045490.git.mchehab+samsung@kernel.org>
        <20190611083731.GS21222@phenom.ffwll.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 11 Jun 2019 10:37:31 +0200
Daniel Vetter <daniel@ffwll.ch> escreveu:

> On Sat, Jun 08, 2019 at 11:27:23PM -0300, Mauro Carvalho Chehab wrote:
> > Sphinx need to know when a paragraph ends. So, do some adjustments
> > at the file for it to be properly parsed.
> > 
> > At its new index.rst, let's add a :orphan: while this is not linked to
> > the main index.rst file, in order to avoid build warnings.
> > 
> > that's said, I believe that this file should be moved to the
> > GPU/DRM documentation.  
> 
> Yes, but there's a bit a twist: This is definitely end-user documentation,
> so maybe should be in admin-guide?
> 
> Atm all we have in Documentation/gpu/ is internals for drivers + some
> beginnings of uapi documentation for userspace developers.

On media, we have several different types of documents:

- uAPI - consumed by both userspace and kernelspace developers;
- kAPI - consumed by Kernel hackers;
- driver-specific information. Those are usually messy, as some contain
  specific internal details, while others are pure end-user documentation.

there are several cross-references between uAPI and kAPI parts.

I've seem similar patterns on several other driver subsystems.

I agree with Jon's principle that the best is to focus the book per
audience. Yet, trying to rearrange the documentation means a lot of work,
specially on those cases where a single file contain different types of
documentation, like on media driver docs.

> Jon, what's your recommendation here for subsystem specific
> end-user/adming docs?

Jon, please correct me if I' wrong, bu I guess the plan is to place them 
somewhere under Documentation/admin-guide/.

If so, perhaps creating a Documentation/admin-guide/drm dir there and 
place docs like EDID/HOWTO.txt, svga.txt, etc would work.

Btw, that's one of the reasons[1] why I opted to keep the files where they
are: properly organizing the converted documents call for such kind
of discussions. On my experience, discussing names and directory locations
can generate warm discussions and take a lot of time to reach consensus.

[1] The other one is to avoid/simplify merge conflicts.

> 
> Thanks, Daniel
> 
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/EDID/{HOWTO.txt => howto.rst}   | 31 ++++++++++++-------
> >  .../admin-guide/kernel-parameters.txt         |  2 +-
> >  drivers/gpu/drm/Kconfig                       |  2 +-
> >  3 files changed, 22 insertions(+), 13 deletions(-)
> >  rename Documentation/EDID/{HOWTO.txt => howto.rst} (83%)
> > 
> > diff --git a/Documentation/EDID/HOWTO.txt b/Documentation/EDID/howto.rst
> > similarity index 83%
> > rename from Documentation/EDID/HOWTO.txt
> > rename to Documentation/EDID/howto.rst
> > index 539871c3b785..725fd49a88ca 100644
> > --- a/Documentation/EDID/HOWTO.txt
> > +++ b/Documentation/EDID/howto.rst
> > @@ -1,3 +1,9 @@
> > +:orphan:
> > +
> > +====
> > +EDID
> > +====
> > +
> >  In the good old days when graphics parameters were configured explicitly
> >  in a file called xorg.conf, even broken hardware could be managed.
> >  
> > @@ -34,16 +40,19 @@ Makefile. Please note that the EDID data structure expects the timing
> >  values in a different way as compared to the standard X11 format.
> >  
> >  X11:
> > -HTimings:  hdisp hsyncstart hsyncend htotal
> > -VTimings:  vdisp vsyncstart vsyncend vtotal
> > +  HTimings:
> > +    hdisp hsyncstart hsyncend htotal
> > +  VTimings:
> > +    vdisp vsyncstart vsyncend vtotal
> >  
> > -EDID:
> > -#define XPIX hdisp
> > -#define XBLANK htotal-hdisp
> > -#define XOFFSET hsyncstart-hdisp
> > -#define XPULSE hsyncend-hsyncstart
> > +EDID::
> >  
> > -#define YPIX vdisp
> > -#define YBLANK vtotal-vdisp
> > -#define YOFFSET vsyncstart-vdisp
> > -#define YPULSE vsyncend-vsyncstart
> > +  #define XPIX hdisp
> > +  #define XBLANK htotal-hdisp
> > +  #define XOFFSET hsyncstart-hdisp
> > +  #define XPULSE hsyncend-hsyncstart
> > +
> > +  #define YPIX vdisp
> > +  #define YBLANK vtotal-vdisp
> > +  #define YOFFSET vsyncstart-vdisp
> > +  #define YPULSE vsyncend-vsyncstart
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 3d072ca532bb..3faf37b8b001 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -930,7 +930,7 @@
> >  			edid/1680x1050.bin, or edid/1920x1080.bin is given
> >  			and no file with the same name exists. Details and
> >  			instructions how to build your own EDID data are
> > -			available in Documentation/EDID/HOWTO.txt. An EDID
> > +			available in Documentation/EDID/howto.rst. An EDID
> >  			data set will only be used for a particular connector,
> >  			if its name and a colon are prepended to the EDID
> >  			name. Each connector may use a unique EDID data
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 6b34949416b1..c3a6dd284c91 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -141,7 +141,7 @@ config DRM_LOAD_EDID_FIRMWARE
> >  	  monitor are unable to provide appropriate EDID data. Since this
> >  	  feature is provided as a workaround for broken hardware, the
> >  	  default case is N. Details and instructions how to build your own
> > -	  EDID data are given in Documentation/EDID/HOWTO.txt.
> > +	  EDID data are given in Documentation/EDID/howto.rst.
> >  
> >  config DRM_DP_CEC
> >  	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
> > -- 
> > 2.21.0
> >   
> 



Thanks,
Mauro
