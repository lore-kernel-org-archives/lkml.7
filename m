Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E12C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2161D20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfCHN0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:26:55 -0500
Received: from www62.your-server.de ([213.133.104.62]:56646 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHN0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:26:55 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h2FWQ-0002ys-NN; Fri, 08 Mar 2019 14:26:46 +0100
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h2FWQ-0006PF-Cr; Fri, 08 Mar 2019 14:26:46 +0100
Subject: Re: [PATCH V3] bpf: fix warning about using plain integer as NULL
To:     Bo YU <tsu.yubo@gmail.com>, ast@kernel.org, kafai@fb.com,
        ongliubraving@fb.com, yhs@fb.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuzibode@126.com
References: <20190308064551.17437-1-tsu.yubo@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <27188c5f-c1e4-44df-7553-1529332f41f8@iogearbox.net>
Date:   Fri, 8 Mar 2019 14:26:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190308064551.17437-1-tsu.yubo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25382/Fri Mar  8 09:55:42 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2019 07:45 AM, Bo YU wrote:
> Sparse warning below:
> 
> sudo make C=2 CF=-D__CHECK_ENDIAN__ M=net/bpf/
> CHECK   net/bpf//test_run.c
> net/bpf//test_run.c:19:77: warning: Using plain integer as NULL pointer
> ./include/linux/bpf-cgroup.h:295:77: warning: Using plain integer as NULL pointer
> 
> Fixes: 8bad74f9840f ("bpf: extend cgroup bpf core to allow multiple cgroup storage types")
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>

Applied, thanks!
