Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D980EC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A025621855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530760;
	bh=j8ToKV0j6N+aTUB5Ddo9FXh80XRs9xxG8OJjm2AhNA0=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=VLQt0RAb2pl4FlUkrmX/JRInBWwzrOanM4t46YIx/Z5txZXtsFkSAnkQkK7uMNNeF
	 iYdj7pN4qGKTtEqhmF7kY52q8RtHYjd6Ccq3kdTxEPJ6qJqgcYbm2PbgYDQAiJh9UH
	 H9nzk4AgaujRpN8jUcgHp9poyGV1J7F6Lpa5cbpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfDFGF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:05:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42687 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfDFGF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:05:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so4189484pgh.9;
        Fri, 05 Apr 2019 23:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=CskRtVCENjBajkVPIacm4K2uKG6i1UBZf3SVorZ7mUg=;
        b=DgTN0ZDMaluABK5bHCIgZz9uCFmcB7lpbNO7D3dBkW9SgxkQ+bUHBmHCfW5OxCkV+z
         ISgVH13BxHjvLQU3u4VP8XNMJorRrHDN2VyeWTZ1yy0E4slFNGqjMSM/6vQ4wk4hdlg5
         aJXPxVaPKuN3SPxo9kdlJiki4OSK0WTXfogqOujFbdM2JiKDIi4PBPpvk9NEeAJ1rrAd
         o3Q6kX4Ef9p2oZ41Kd7zgaiwbuZ+Z8OAZ8DXibbtc02J5wTIh/3DLaglFkypv3OxFAR+
         GHNOSkmhDNZEjriAexek0GN6BwSw/oS1JVi7dlkK2IOXIA6cgW8CXHQYQ9cTPl8X4ZKv
         bmzg==
X-Gm-Message-State: APjAAAVBdl7Cku87HHX6a2ylyyZ8NGrJkxv8EGbtEvBpB7rU0d0A588r
        n+xZEtNSU4U6PwZhbH+iAQ==
X-Google-Smtp-Source: APXvYqyCjX1d2UskRIv044v+RG3zrowiRGyqt8a07w017DhMaCLz3c8SukFPzQhyiXHFbxprgZ+ZaQ==
X-Received: by 2002:a62:388d:: with SMTP id f135mr16954248pfa.103.1554530757204;
        Fri, 05 Apr 2019 23:05:57 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id e126sm46538706pfh.35.2019.04.05.23.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:05:56 -0700 (PDT)
Message-ID: <5ca841c4.1c69fb81.f74fb.c7e1@mx.google.com>
Date:   Sat, 06 Apr 2019 01:05:54 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
References: <20190330055038.18958-1-sergio.paracuellos@gmail.com> <20190330055038.18958-2-sergio.paracuellos@gmail.com>
In-Reply-To: <20190330055038.18958-2-sergio.paracuellos@gmail.com>
Cc:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, devicetree@vger.kernel.org,
        john@phrozen.org, linux-mips@vger.kernel.org, robh+dt@kernel.org,
        neil@brown.name
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2019 06:50:37 +0100, Sergio Paracuellos wrote:
> Add bindings to describe Mediatek MT7621 PCIe PHY.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../bindings/phy/mediatek,mt7621-pci-phy.txt  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

