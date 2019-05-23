Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D30EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A62021019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558617751;
	bh=fafG5urEIcaBd2TyvSTWRmea9cT2jasXKlmsCh3VSws=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=f5DHb9y5b7XpdudofjpTS/8ljQO5OzJRHsfOHcqPmD8nCxPiBfxi7N4d0DQixeOso
	 DvHSnk/AD3uj0Wn1OY53SmX8GElbQjl+PTS2nvw/Hc/PbWyH9MiNAES/vb0Ph5NfXk
	 wrUuIJfSQxxn5SKT3iXQeoUx3BkhZ7sL3t2RaOkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfEWNWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfEWNWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:22:30 -0400
Received: from [192.168.0.101] (unknown [58.212.135.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B5820862;
        Thu, 23 May 2019 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558617749;
        bh=fafG5urEIcaBd2TyvSTWRmea9cT2jasXKlmsCh3VSws=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=SMVTE6A4oqESJX9PxuakmNe2snGrj3s+XpCTQWn5c4j/5ndOSXvTvjclhmnXiMdRg
         i7P8i4DcErB+Ep49l+Zy0XBcDodiMg48o1HXSRPGQYeWxbLrYgHyHSuAYnDzPbT89d
         QiQr2ud0LT7Zp5Y/NRon8ijRwPYlySFjK64Rp5VU=
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add missing sysfs entries in
 documentation
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190521180606.10461-1-jaegeuk@kernel.org>
 <20190522175035.GB81051@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <14672901-54a2-120f-a2ce-52f7d6fb3008@kernel.org>
Date:   Thu, 23 May 2019 21:22:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190522175035.GB81051@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-5-23 1:50, Jaegeuk Kim wrote:
> This patch cleans up documentation to cover missing sysfs entries.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> + reserved_blocks	      This parameter indicates the number of blocks that
> +			      f2fs reserves internally for root.
> +

I mean we can move below entry here.

current_reserved_blocks	      This shows # of blocks currently reserved.

> + reserved_blocks	      This shows # of blocks currently reserved.

Thanks,
