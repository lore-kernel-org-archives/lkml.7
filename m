Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E97C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC702146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553028842;
	bh=1zoo+BRS/GB8kWjsXTpn0+HuEOeH90GfdroGPUJtKUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wSfQtqH0kKIUELO18U9bUVPjUtgR5o3MTCJLqYlKXtYS+6HgqxjuJIhSPZLgU96jQ
	 ienVbSQ0ZH+Mns2W+r8GeWCb/5FFbLFdQeATcnrHAWn+F9jn5M6QKHNGbxG1R9s1sT
	 v55jWZWtr79+UzYVZHbO5diCe/35nsHWM4Jz52gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCSUyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:54:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35865 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfCSUyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:54:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so395590wrd.3;
        Tue, 19 Mar 2019 13:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DI7b4vbc/Sliz3fIo8bDUCfSigtpseBZ+fp0B3j934s=;
        b=enAisG266unW62NOq08fRae5pwQH7MYz3SSitpAkJxXx8fTaNe2cy61gGwO7+9zbQh
         C9A6kgxQqRCZVSpPnLWRUahQ89wZcq2mWBW7mK9UQMHWw2bT148wqvzvbgFtarGPu0lx
         +QMEUS3v2EEOAXemKT+n0nV+/OzFQNAzBXi8VJ7Rg210Z1qGFpFfM6wbbJzj7xqVnwlw
         bIv+o8unmW3SQKzdTjxyioMFbrN+i8o3PgM9UjIO1WeB4YFQE46OzGIPQcMhl99lF+9G
         OvxWfCziwi7LGcqjkKz8NHRFdrUiP9pJ9Am98cRCAY8fy/aWG7oLZFtqHUO9L3CQ7Z2t
         1dfw==
X-Gm-Message-State: APjAAAXnPP+1ntt/1C1DTqOKizVhlYeQLVfHnRDLNMmQWSrINMg68er8
        +IV5LnFvAQghXH19bzQbHmM=
X-Google-Smtp-Source: APXvYqzwoP2xKU2vE1pnz6kpMxIuC00ueIlyUiM8eEyyFdPTyIq3I9s2sRmIoH+RaOdnNjaHW5WI9g==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr16838098wru.186.1553028838730;
        Tue, 19 Mar 2019 13:53:58 -0700 (PDT)
Received: from kozik-lap ([194.230.155.153])
        by smtp.googlemail.com with ESMTPSA id h131sm8221773wmh.1.2019.03.19.13.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 13:53:57 -0700 (PDT)
Date:   Tue, 19 Mar 2019 21:53:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: exynos: Fix audio routing on
 exynos5422-odroidxu3
Message-ID: <20190319205355.GC16150@kozik-lap>
References: <CGME20190306104113epcas1p4a12ebf1aac63883cbd80b2750be76d06@epcas1p4.samsung.com>
 <20190306104056.7603-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306104056.7603-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 11:40:56AM +0100, Sylwester Nawrocki wrote:
> Add missing audio routing entry for the capture stream, this change
> is required to fix audio recording on Odroid XU3.
> 
> Fixes: 885b005d232c ("ARM: dts: exynos: Add support for secondary DAI to Odroid XU3")

Thanks, applied.

Best regards,
Krzysztof

