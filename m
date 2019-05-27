Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB05C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5987220673
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfE0WJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:09:49 -0400
Received: from zangief.bwidawsk.net ([107.170.211.233]:45662 "EHLO
        mail.bwidawsk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfE0WJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:09:49 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2019 18:09:49 EDT
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
        id 66CFF12340B; Mon, 27 May 2019 15:03:01 -0700 (PDT)
Received: from mail.bwidawsk.net (c-73-25-164-31.hsd1.or.comcast.net [73.25.164.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.bwidawsk.net (Postfix) with ESMTPSA id D84311233FB;
        Mon, 27 May 2019 15:02:58 -0700 (PDT)
Date:   Mon, 27 May 2019 15:02:58 -0700
From:   Ben Widawsky <ben@bwidawsk.net>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     hao.wu@intel.com, atull@kernel.org, mdf@kernel.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH -next] fpga: dfl: fme: Remove set but not used variable
 'fme'
Message-ID: <20190527220258.jcbqfww4mxnhee3v@mail.bwidawsk.net>
References: <20190527153424.10268-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527153424.10268-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-27 23:34:24, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/fpga/dfl-fme-main.c: In function fme_dev_destroy:
> drivers/fpga/dfl-fme-main.c:216:18: warning: variable fme set but not used [-Wunused-but-set-variable]
> 
> It's never used since introduction in commit 29de76240e86 ("fpga:
> dfl: fme: add partial reconfiguration sub feature support")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Ben Widawsky <ben@bwidawsk.net>

[snip]
