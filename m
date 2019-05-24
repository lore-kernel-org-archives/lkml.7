Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064F8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF772133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558699610;
	bh=cPBX6jHeyb1Yu8aEf1AqEQATln5ZXRSmxrNwVvHQB98=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=LgSzOhOEPKisFAQEE1Lm1DZ9aGFntUgw4x4rSVfoQddSF5LYLnri981seN31G2Tjh
	 llPOGu35D417lMl3fH5a4cyfK9jVrT7BmyfiA36ZmAjMY3vbUDwfrqrLbJs9rLdILm
	 s2okE2XuImAQSG48fu9Cc6Jm0YJR5er0bKnXcnjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391381AbfEXMGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391216AbfEXMGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:06:49 -0400
Received: from [192.168.0.101] (unknown [58.212.135.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F46820851;
        Fri, 24 May 2019 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558699609;
        bh=cPBX6jHeyb1Yu8aEf1AqEQATln5ZXRSmxrNwVvHQB98=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wJUG4DC4hWwkvGhOSJJeh9CQ5ucC72V1/D+TF5HyxTwqTkOfuajz3sFtIASyYtRiv
         n1/KjXhUUdZNJS1R0vgGMfcbtKd00qvT85DJ8jNaMMjQxqz47u6Cps5Dverpt3l4BU
         GBXYa2+GzroKOQ+RK6iB9VDkAcKkrPRfKyt8EQ8Y=
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix f2fs_show_options to show nodiscard
 mount option
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org
References: <1558688919-561-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f1fb0153-3b77-5e08-d13a-162ea87ac0ff@kernel.org>
Date:   Fri, 24 May 2019 20:06:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1558688919-561-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-5-24 17:08, Sahitya Tummala wrote:
> Fix f2fs_show_options to show nodiscard mount option.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
