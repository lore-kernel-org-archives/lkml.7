Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F3CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D409D2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556118422;
	bh=NYCPHVsbfHe7qGYtQ78VfRIo2zvEfLEToElSUf+m9/8=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=Mj8n2FKcOs5CMg37G7lX9o5GvqYvO5ul6w3iErLXn2CMcmU/Yi32tjfdPQQHKajYu
	 7NTRB55Onx/S8GraivzS2U/K7m8bFnA6O0bYZ+nr177qYTOixyH3K24KAYK6/4BhAR
	 Vo5+43PwaB8t6gO1rg9nEsaGzOghMxXwY6FqMazA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfDXPHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfDXPHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:07:00 -0400
Received: from [192.168.0.101] (unknown [58.212.133.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522962084F;
        Wed, 24 Apr 2019 15:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556118420;
        bh=NYCPHVsbfHe7qGYtQ78VfRIo2zvEfLEToElSUf+m9/8=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=P5ZubeEJR55oHtSpYWq/McTAsn21hwvVprFz99xYsIa9nf7E6KSjQp1I+hDxHMHRc
         SQTlUiMSCj5P6fCERO5tEei/ZdRmAJoLnxjpTTmsDoC1kIxNKZ7IIZiIgdlGa0JQhf
         2NIBnDqyApLx1Ccl86WbzlH1+aFWTRL4xcSqGUUc=
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools:fix memory leak in write dquot
To:     Xiaojun Wang <wangxiaojun11@huawei.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <1556088462-21693-1-git-send-email-wangxiaojun11@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <7a25bd27-345d-57e3-3252-7c9e2f218d8f@kernel.org>
Date:   Wed, 24 Apr 2019 23:06:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1556088462-21693-1-git-send-email-wangxiaojun11@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-4-24 14:47, Xiaojun Wang wrote:
> this patch free ddquot in qtree_write_dquot to avoid memory leak
> 
> Signed-off-by: Xiaojun Wang <wangxiaojun11@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

