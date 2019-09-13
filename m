Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ACAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B151520693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404029AbfIMWVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:21:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390452AbfIMWVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:21:48 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4AAD76525
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 22:21:47 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id s14so1007597qtn.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 15:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=JP4jP6mpEPQIK7y8sW6Sm0fCYeb5xv15y7wA/cmFkyw=;
        b=qJwwrdOhFCdseEOVmn38nDzUGRbYlT4i3navyM7cOriyVCbq7ayKuN/P+Z80wZnRLx
         psYGGeg77NFChDjhmmuH+3wtHJViTAqP8bcWWVQ22/ZVFPPvXXdm07GJIU7BDM3q4jYQ
         qg6YAzbp3nf4io3brt/PfJ3OjTSxtTRLUuFfNwnKZbVT7s2WizGURfLtF8mSOo/CJANi
         9VQ0ZvJaXIKHosUcFHflrWvDNX+f+C4ZoHsmvFu15XA3k9WzbMSG3ntW5fdwN829Hn41
         e3YLAxGD306xzMSM/vO12R5WEtfZWtR8fk+uTKIu4JpL5a7k3LO4PhpnU/Y6luS6W3wV
         cBdA==
X-Gm-Message-State: APjAAAUanxx8z0NTxq6I3t7EehWIe+k999bxovJOvO0L8zM2xHPZbM+f
        Qy9LsA1uPJxvT8DnaRxztkOA1JcSSQWYclxMvj7QOuruug5Hp/Yh5/5m3+XMl3NFI54Gv9NNWA4
        ohpIreA97QcXN/BnmS1gbFuNr
X-Received: by 2002:ac8:760e:: with SMTP id t14mr5745153qtq.175.1568413307109;
        Fri, 13 Sep 2019 15:21:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNcQUL3hq0iC38keGiPsp4lrFZMdU6Rmc/zogZLcerutTN40gUktNk6Sbz0VYRaa1/dEvUsg==
X-Received: by 2002:ac8:760e:: with SMTP id t14mr5745135qtq.175.1568413306922;
        Fri, 13 Sep 2019 15:21:46 -0700 (PDT)
Received: from dhcp-10-20-1-34.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id 60sm14417517qta.77.2019.09.13.15.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 15:21:46 -0700 (PDT)
Message-ID: <648aabc005e7cffa50060cd60452135a1a4d7818.camel@redhat.com>
Subject: Re: [PATCH 2/4] drm/nouveau: dispnv50: Remove
 nv50_mstc_best_encoder()
From:   Lyude Paul <lyude@redhat.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 13 Sep 2019 18:21:44 -0400
In-Reply-To: <CAKb7UvgQE0UDTvvhbq4FgtgOWjvXDDKSZs8RSLA-ECa2YZiFLA@mail.gmail.com>
References: <20190913220355.6883-1-lyude@redhat.com>
         <20190913220355.6883-2-lyude@redhat.com>
         <CAKb7UvgQE0UDTvvhbq4FgtgOWjvXDDKSZs8RSLA-ECa2YZiFLA@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-13 at 18:20 -0400, Ilia Mirkin wrote:
> On Fri, Sep 13, 2019 at 6:05 PM Lyude Paul <lyude@redhat.com> wrote:
> > When drm_connector_helper_funcs->atomic_best_encoder is defined,
> > ->best_encoder is ignored both by the atomic modesetting helpers. That
> 
> By both the atomic modesetting helpers and ... (usually "both" implies 2
> things)

good catch, will fix and respin in a moment
> 
> > being said, this hook is completely broken anyway - it always returns
> > the first msto for a given mstc, despite the fact it might already be in
> > use.
> > 
> > So, just get rid of it. We'll need this in a moment anyway, when we make
> > mstos per-head as opposed to per-connector.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/dispnv50/disp.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > index b46be8a091e9..a3f350fdfa8c 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > @@ -920,14 +920,6 @@ nv50_mstc_atomic_best_encoder(struct drm_connector
> > *connector,
> >         return &mstc->mstm->msto[head->base.index]->encoder;
> >  }
> > 
> > -static struct drm_encoder *
> > -nv50_mstc_best_encoder(struct drm_connector *connector)
> > -{
> > -       struct nv50_mstc *mstc = nv50_mstc(connector);
> > -
> > -       return &mstc->mstm->msto[0]->encoder;
> > -}
> > -
> >  static enum drm_mode_status
> >  nv50_mstc_mode_valid(struct drm_connector *connector,
> >                      struct drm_display_mode *mode)
> > @@ -990,7 +982,6 @@ static const struct drm_connector_helper_funcs
> >  nv50_mstc_help = {
> >         .get_modes = nv50_mstc_get_modes,
> >         .mode_valid = nv50_mstc_mode_valid,
> > -       .best_encoder = nv50_mstc_best_encoder,
> >         .atomic_best_encoder = nv50_mstc_atomic_best_encoder,
> >         .atomic_check = nv50_mstc_atomic_check,
> >  };
> > --
> > 2.21.0
> > 
-- 
Cheers,
	Lyude Paul

