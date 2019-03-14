Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF721C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13F721855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552574067;
	bh=BMq4u87FGb2gFidcUvEqFQHf236hbaYxuFFmXfDMhao=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=HRjASAKKp7JIovNFuRUgD9U+N7Apv2KobJ8rx7bwXMTopi8M4dexW4365GYnAB80P
	 LJvBMclzYAc4L2kVd6gOibW+zledeTHDU8nC0q+9+Ls+7PZYgihTihG6pf/3KMY1WZ
	 NrHZTC7SgzwTRgzrFjzpPGL86zZn8IDe96Z+pY2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfCNOe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfCNOeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:34:25 -0400
Received: from [192.168.0.101] (unknown [49.77.249.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80C172184C;
        Thu, 14 Mar 2019 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552574065;
        bh=BMq4u87FGb2gFidcUvEqFQHf236hbaYxuFFmXfDMhao=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ZhWiqB6nPAerNt0W9VCn/tFjU6br69Hthawh9kSF1HyrtQE/7gMdcA6mFVrER2daO
         CgOiY4nGrRQhP5FEpdwwuq6THWVYAKvmNVIOLFjDCroz9w1oLVmIIaiKrws9W12jao
         YDcJX3v/Aj6HNP3YNM0G4Hch79DJiXf8+2U9ey+8=
Subject: Re: [f2fs-dev] [PATCH] f2fs: set pin_file under CAP_SYS_ADMIN
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190313231619.31453-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <394e84f9-73d6-ae5a-40da-64c864b7c7ee@kernel.org>
Date:   Thu, 14 Mar 2019 22:34:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190313231619.31453-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-3-14 7:16, Jaegeuk Kim wrote:
> Android uses pin_file for uncrypt during OTA, and that should be managed by
> CAP_SYS_ADMIN only.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
