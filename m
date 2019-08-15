Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E00C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD9E2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565893476;
	bh=P5YFuEJVGL8KpMLspUX41IugnCTcMVKfVU+sG6Ovxi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vUDFd8vrKh8bYRLhWF4IRRNz2f6DywV9+s447FqxHlx6EL7CVoovdYlz/3TlkKBTO
	 Yfm3IZYowGBUVgOBpRBIoUxcGb7DCy98IRTH7jOosAASnQ/84ed8aDzy6m62dmzW0a
	 QN+kBLsyk4k1UGNS0nCCoDtDjDKdO1ksmNXvKbKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbfHOSYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:24:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37309 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbfHOSYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:24:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so2033211wmf.2;
        Thu, 15 Aug 2019 11:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I8LpUlYZvhVr6pk/y17OXv83aq2SFVNq4KhnnC2cLW4=;
        b=WQh37+3lZfAA/YK+zAM5dho2T6B4BzCBtQXQMFYHiWylt6yehqMRnuM8djJjAUQCxI
         OBZl1ahTRbbMwozoPoPl+hBcNSWHJr4F4F6Cvn5FXaad3oHQpU9QiNH4F+GerC6rMi7q
         awJJXDr5MOGAvyu9/E5YDtZbDPrOrtGeJYXNqVWp4tCntYEll0BrY+5XF8U57gW+Ay/7
         7UhcmOK2GNfUZ6LldY4AYgdT1qoOoKGppsWQCYGhsIRk9mCyJqNa1nYiRJ723RA5wGUI
         nf6l7R83KBdtG46vFkIDg4cPV9hoJVIPrInTSuhbA+m81Zr3bfryXB35hZ7LiLrHr87K
         zobg==
X-Gm-Message-State: APjAAAVS8MYy6UadwvWXBq5QL2emShE417nGPfDNFxbrHpRZrXANnVXJ
        V2zArSHZdxsdPr2lbbUoNWc=
X-Google-Smtp-Source: APXvYqxK3boAcUy6fh+CU/UaSq4E+pD5s5IvBqlD5jfe0NnSfwNIE99uIt2toexVhRW42hSSyaU2AA==
X-Received: by 2002:a1c:c5c2:: with SMTP id v185mr4214329wmf.161.1565893472805;
        Thu, 15 Aug 2019 11:24:32 -0700 (PDT)
Received: from kozik-lap ([194.230.155.124])
        by smtp.googlemail.com with ESMTPSA id o9sm2587458wrj.17.2019.08.15.11.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 11:24:32 -0700 (PDT)
Date:   Thu, 15 Aug 2019 20:24:30 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 7/9] soc: samsung: Update the CHIP ID DT binding
 documentation
Message-ID: <20190815182430.GD14360@kozik-lap>
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
 <CGME20190813150858eucas1p1a5fbf425753e4911c50631c3a6d34ffd@eucas1p1.samsung.com>
 <20190813150827.31972-8-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190813150827.31972-8-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:08:25PM +0200, Sylwester Nawrocki wrote:
> This patch adds documentation of a new optional "samsung,asv-bin"
> property in the chipid device node and documents requirement of
> "syscon" compatible string.  These additions are needed to support
> Exynos ASV (Adaptive Supply Voltage) feature.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - none
> 
> Changes since v1 (RFC):

Title should match bindings, so:
dt-bindings: samsung:

Also please put it before the driver change using these bindings.

Best regards,
Krzysztof

