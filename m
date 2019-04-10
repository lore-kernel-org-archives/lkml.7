Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9EFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F9A2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554904769;
	bh=jXwIpKTWhK4WhGWSx0dgv4Ri+QxByGIYKZouewcJd5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ByMmHv1WI4jHBWcLdafchn5Qre7+QdpFnRcyZGZ5j9H888Wwvtjw3T1D1izallfw/
	 RN4cCNIvpLa9vqw1UkL3gkpmK5K5OpY94Gv9p8BmTeg7I2Q+qN2lZCMV8EfgbizP+l
	 75aPwt9tJfSWzekkKLxVUMRFa1bch2AtZ4XtRUM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbfDJN71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:59:27 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37893 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfDJN71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:59:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id a6so1830090oie.5;
        Wed, 10 Apr 2019 06:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sOcWLxngcxrgHrEKx1jLTi+nTwp2gn480DokLPIHTGs=;
        b=Q/fzKXlTm79iaRoKy/zQuivsWpvfZzpKJuYP4zgNDJ1Rgs9yPPbbOGlbXbeAbat6LU
         I6zNRPS7gqkDQpBDubbdC+2+V2D+qTDpuriRHSU4bTlUhmhpdeuwhOOG5e/oAuZr+xaK
         pbSUf6K8L7mT5sAg9FT3nxj7tQUIGLnNVtBBXUtnJYUbuBVeVwIt1CPP2VF2H5OJFJtZ
         HZVwoPz+X4eR0GkbGU7yvSeqtUTt8yk+F3KrEimDP6xIYi0w8oJzQenkigm8HWT+Cv13
         bOVQ9oecwRYkTsxbXfH1uMSJ7FeLCST6qWuVHIkI2YZwpqlOLHRF2i4/Zb4vAp+WebwR
         ueUQ==
X-Gm-Message-State: APjAAAW1rbiSnT1eEsciB8hDZpHe18Ggl2SLXGd4wjEX2sMYWK300bGv
        F+/+aBBF4lxXeQWpMqXJAg==
X-Google-Smtp-Source: APXvYqzZHPYCmNy36JUyCAVoUL7IjVBbjZzn36cKVHJt6uUqskt9v1xXk8V4wqahHnQvVcqgnQwACg==
X-Received: by 2002:aca:fd93:: with SMTP id b141mr2457698oii.153.1554904766232;
        Wed, 10 Apr 2019 06:59:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o203sm8008965oia.20.2019.04.10.06.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 06:59:25 -0700 (PDT)
Date:   Wed, 10 Apr 2019 08:59:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     frowand.list@gmail.com,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: use correct function prototype for
 of_overlay_fdt_apply()
Message-ID: <20190410135925.GA1627@bogus>
References: <20190322002342.24831-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322002342.24831-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:23:41PM +1300, Chris Packham wrote:
> When CONFIG_OF_OVERLAY is not enabled the fallback stub for
> of_overlay_fdt_apply() does not match the prototype for the case when
> CONFIG_OF_OVERLAY is enabled. Update the stub to use the correct
> function prototype.
> 
> Fixes: commit 39a751a4cb7e ("of: change overlay apply input data from unflattened to FDT")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  include/linux/of.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied.

Rob
