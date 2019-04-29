Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA6EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF3D20675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556560216;
	bh=mFI5AYacw1Q6qyrXUN2Ehpqx6CfqN/shmO2DBD0NVZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Su3pxuBGyosOrYDOLDvYwmGS7R91avlYsp6XsioKqjdoq2sNR/IKsKfhtfJW3K7d+
	 jQEenBKLy7/in2uocXNKDQpiN75WqacH0FJ4P5oqG+WDdnS/APw5ZEvRRQU6anCWK5
	 2BRyceHhdvOZQRQ48nYjsPuaihslt6sduu7xRhDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfD2RuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:50:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37038 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2RuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:50:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id r20so8305055otg.4;
        Mon, 29 Apr 2019 10:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GP+/q3SjbJoSSjp2k2erddqMqGbf2+izieUaA6gaXfQ=;
        b=c+z3GcJ5yNzmRVz1NWrlin9+SDadyStYIsiTLvgksxkdQZWqyk0wmANnOoCgWvpMdz
         ZsIyQAuRWnlvHHfiINAo43AdZsmhND7Ox2AB7ex5N+5j0tD/fPB0aBYD5RSpeqp+prYb
         369PQuNe4x63sxWluaRhFYusMQ29UOkNWG/ZeLvkEI/mLSPylO7T+CuB5bAE/aaA2TZB
         207IeeWjj3JVBLFf2wqEHRqVTAvWpZy2vye3AOgfaTClLzRLYoEtBeUkzeOXrcLePgun
         5KJRmNvhowjZ6Aym5YnUYY3Bb1U0xyrK7I7j8dO8PrADTRA3SUSCdz8AMk2Pl2DLDTN4
         bCgg==
X-Gm-Message-State: APjAAAXS6nMV9JbJqUhYhyl1KJilHzOF9/NGMpVPw67aVDpU/zgpBL8L
        3ItTaQgSjreFoPxbbbHqpA==
X-Google-Smtp-Source: APXvYqwYHRkEoyFICdeOxSu5L1aOWeH3YczEJDsM2TY8TnSAxpi+K+WzJgo1yEK67ZaYo8lCeuj15A==
X-Received: by 2002:a9d:650e:: with SMTP id i14mr19253606otl.128.1556560214260;
        Mon, 29 Apr 2019 10:50:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h37sm1920163oth.79.2019.04.29.10.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:50:13 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:50:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     xiaojiangfeng <xiaojiangfeng@huawei.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: del redundant type conversion
Message-ID: <20190429175012.GA28972@bogus>
References: <1554884981-20309-1-git-send-email-xiaojiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554884981-20309-1-git-send-email-xiaojiangfeng@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:29:41PM +0800, xiaojiangfeng wrote:
> The type of variable l in early_init_dt_scan_chosen is
> int, there is no need to convert to int.
> 
> Signed-off-by: xiaojiangfeng <xiaojiangfeng@huawei.com>
> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Rob
