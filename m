Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A63ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B661B2067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571179623;
	bh=i0z+4ff2BbcFIrsEcJBQHMtWZXFjEeTTKR2zOTYvES4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K0vDijP2Lbi6JwliDDbfyCHCcVjsuBXaojK9shv7tV/MTLDU66IyY5DdRwHhvyrF2
	 AmipKh6lvZjz0lHob5O89SYfz+7EqKyVF8FYykld5ZpXc0WfNUovGZ6CIUYok3KCr+
	 AP20HFdE5Cw1eAql//qlt1hS+BJryRi+cuWktIPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390094AbfJOWrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:47:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38713 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfJOWrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:47:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id m16so18342883oic.5;
        Tue, 15 Oct 2019 15:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C6wXRtpbEpzp24GuIHDI6uFCDF6VV7WToyM7YY1OIxQ=;
        b=eGVYGg9wfv/UXrbdGkMVHgmPW6flLwRGWQc02+jQaWkMZ+NGyurwc2mvcrLJqXMUUk
         L+HlpW6Tssw4J/oBRy5RS05+TVLI4PI6B+h7JDSpmNqrb4itSruBzD1lOfI9cijt1xsQ
         PfLoDZVbwpAZdVLRNLWvGPqkyw6F+p4WvEUI1+cAQN4HJyCzEaaMTQx1dgr+H5B5u7BO
         uaOxzpn/rI2XRGigFRFhVFDvuzRYtPNKBMnbRR3AI+sZatmz7gCCs/w1ObTn8LWFyreN
         HMfR6fMzq/vCa17SgQVkm31ugLYfDoXL3zfmH4GwXahmTK8r1NWltV0Dzaf8zEOPHQ79
         4Hdg==
X-Gm-Message-State: APjAAAWJj95S3LJansMhIG8e8lwPWGX+ROJQucxZFpDJCAodKPbfxEYn
        W8dLwe4lv/9R14oeE0y4gA==
X-Google-Smtp-Source: APXvYqzfVvWw5j9mzVQMN0v7Wf66qbF22TX9XvtdfnrJk4RPIsSapGqhtHO196+2gpIJxuthWNa7BQ==
X-Received: by 2002:aca:aac5:: with SMTP id t188mr807467oie.39.1571179619358;
        Tue, 15 Oct 2019 15:46:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x38sm7204509ota.59.2019.10.15.15.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:46:58 -0700 (PDT)
Date:   Tue, 15 Oct 2019 17:46:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add vendor prefix for Overkiz SAS
Message-ID: <20191015224658.GA13080@bogus>
References: <20191011125022.16329-1-kamel.bouhara@bootlin.com>
 <20191011125022.16329-2-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011125022.16329-2-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 14:50:20 +0200, Kamel Bouhara wrote:
> Overkiz is a smarthome solutions provider, more information on:
> https://www.overkiz.com
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
