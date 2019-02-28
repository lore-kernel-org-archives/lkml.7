Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057B52133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551365585;
	bh=L4xdRxRoZFwDSVJVik+Yv2lySYyXURLhZ5KjhCPjHW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zNtgznzZdFWNUKDsfOvXC8HcsFREmAWS0yBsei3H2i0OS6ajBGxKwpN8uR52VBFsK
	 Iyl/9MorV27Ct/zzw8Ezh6Qov2voW5oyXzkiKpHNLjy+ucyuIil2OPve9f7qi1jfdh
	 ADRbAaj7a19eWnP9fTX2rU8m5ZX3Wzs023/fZFsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbfB1OxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:53:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40482 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfB1OxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:53:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id x187so16663371oia.7;
        Thu, 28 Feb 2019 06:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s9Vv1TBNek5DFMFU+NNQpjYmahV93/sD4N5xl77tNP0=;
        b=PbU+HtO5mDfRb5HCxH9YO4dQkZ0EBk7iV2drwSgfPqPxIDWuBSr0rf6DW8zVpncrzl
         6e1Q/VaIdDkK4sId4Dfm34M/nF/wGU9HTtliApfP9L1Au768KZEilntqX6JZrW4esHGC
         RpyzdkLug9cQA4FYVgNih3JyRUU1JZAzgpUyhqtqXo7YD55W9Tk7nvBs99s83q1Ya2Up
         1GnSTW+BVhgFIUuiGFudetxEB9IQUFCTnrb5AEluLslPujXndQjCzAGDDEOBM+mh6M8L
         cTvjkY8AEA9BPSW12c1NaiPOtavHxcMLI1WD37/DnY41DQlu7waT4Y7xRZ/KO7TTjLO7
         LpJA==
X-Gm-Message-State: APjAAAUK0I/R0sB8eLQSy1+Blu96SCULpL8QQEGq2y0K8xQmxH24vIJc
        FyjQ7dvTtWFHQmT5qcI6m1EV0DU=
X-Google-Smtp-Source: AHgI3IYLJvkbEfPqw7Lph/P0WdLJYft2WnwPy+9sdeONngoknCO3nNZ0gkwKMzJLUC4cH9RjfWPk5w==
X-Received: by 2002:aca:3786:: with SMTP id e128mr66069oia.120.1551365582202;
        Thu, 28 Feb 2019 06:53:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i9sm3873448otl.43.2019.02.28.06.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:53:01 -0800 (PST)
Date:   Thu, 28 Feb 2019 08:53:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: Add vendor prefix for techstar
Message-ID: <20190228145300.GA17680@bogus>
References: <20190212112744.2332-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212112744.2332-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:57:44PM +0530, Jagan Teki wrote:
> Add vendor prefix for techstar, known as
> Shenzhen Techstar Electronics Co., Ltd. a known producer for LCD modules.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - rebase for master
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied.

Rob
