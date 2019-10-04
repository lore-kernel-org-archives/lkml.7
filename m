Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E709C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4E4215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfJDT2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:28:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:3677 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfJDT2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:28:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 12:28:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="222253171"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 04 Oct 2019 12:28:02 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 04 Oct 2019 22:28:02 +0300
Date:   Fri, 4 Oct 2019 22:28:02 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Eric Engestrom <eric.engestrom@intel.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm: Fix comment doc for format_modifiers
Message-ID: <20191004192801.GJ1208@intel.com>
References: <20191002183011.GA29177@ravnborg.org>
 <20191003075118.6257-1-andrzej.p@collabora.com>
 <20191003135318.GH1208@intel.com>
 <20191004190826.x26gb5wnurmwobej@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191004190826.x26gb5wnurmwobej@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 08:08:26PM +0100, Eric Engestrom wrote:
> On Thursday, 2019-10-03 16:53:18 +0300, Ville Syrjälä wrote:
> > On Thu, Oct 03, 2019 at 09:51:18AM +0200, Andrzej Pietrasiewicz wrote:
> > > To human readers
> > 
> > The commit message is always for human readers, no need to point that
> > out...
> > 
> > > 
> > > "array of struct drm_format modifiers" is almost indistinguishable from
> > > "array of struct drm_format_modifiers", especially given that
> > > struct drm_format_modifier does exist.
> > 
> > ..but this paragraph still manages to 100% confuse this particular human.
> 
> There's an underscore instead of a space on the second line
> (s/drm_format modifiers/drm_format_modifiers/).

OK, so I guess I really am blind.

> 
> It should definitely be reworded to be much clearer.
> 
> > 
> > The actual code changes lgtm, so with the commit message reworded
> > this patch is
> > Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > > 
> > > And indeed the parameter passes an array of uint64_t rather than an array
> > > of structs, but the first words of the comment suggest that it passes
> > > 
> > > Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> > > ---
> > >  drivers/gpu/drm/drm_plane.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> > > index d6ad60ab0d38..0d4f9172c0dd 100644
> > > --- a/drivers/gpu/drm/drm_plane.c
> > > +++ b/drivers/gpu/drm/drm_plane.c
> > > @@ -160,7 +160,7 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
> > >   * @funcs: callbacks for the new plane
> > >   * @formats: array of supported formats (DRM_FORMAT\_\*)
> > >   * @format_count: number of elements in @formats
> > > - * @format_modifiers: array of struct drm_format modifiers terminated by
> > > + * @format_modifiers: array of format modifiers terminated by
> > >   *                    DRM_FORMAT_MOD_INVALID
> > >   * @type: type of plane (overlay, primary, cursor)
> > >   * @name: printf style format string for the plane name, or NULL for default name
> > > -- 
> > > 2.17.1
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 

-- 
Ville Syrjälä
Intel
