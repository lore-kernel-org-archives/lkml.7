Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37D3C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FE820673
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfE0WJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:09:49 -0400
Received: from zangief.bwidawsk.net ([107.170.211.233]:45664 "EHLO
        mail.bwidawsk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfE0WJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:09:49 -0400
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
        id F094812340D; Mon, 27 May 2019 15:03:13 -0700 (PDT)
Received: from mail.bwidawsk.net (c-73-25-164-31.hsd1.or.comcast.net [73.25.164.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.bwidawsk.net (Postfix) with ESMTPSA id BD0021233FB;
        Mon, 27 May 2019 15:03:12 -0700 (PDT)
Date:   Mon, 27 May 2019 15:03:12 -0700
From:   Ben Widawsky <ben@bwidawsk.net>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     hao.wu@intel.com, atull@kernel.org, mdf@kernel.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH -next] fpga: dfl: afu: Remove set but not used variable
 'afu'
Message-ID: <20190527220312.etjg7efr2uekvtqh@mail.bwidawsk.net>
References: <20190527153755.7332-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527153755.7332-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-27 23:37:55, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/fpga/dfl-afu-main.c: In function afu_dev_destroy:
> drivers/fpga/dfl-afu-main.c:529:18: warning: variable afu set but not used [-Wunused-but-set-variable]
> 
> It is never used since introduction in commit
> 857a26222ff7 ("fpga: dfl: afu: add afu sub feature support")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Ben Widawsky <ben@bwidawsk.net>
