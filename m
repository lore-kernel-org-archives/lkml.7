Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7ACC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B362133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfFZOdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:33:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:45082 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZOdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:33:41 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hg8zL-0000g3-6O; Wed, 26 Jun 2019 16:33:31 +0200
Received: from [2a02:1205:5054:6d70:b45c:ec96:516a:e956] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hg8zL-000Lro-0N; Wed, 26 Jun 2019 16:33:31 +0200
Subject: Re: [PATCH net-next] xdp: Make __mem_id_disconnect static
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        ast@kernel.org, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
References: <20190625023137.29272-1-yuehaibing@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bbd0b831-8ffa-1993-0a2a-06c1102f3292@iogearbox.net>
Date:   Wed, 26 Jun 2019 16:33:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190625023137.29272-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25492/Wed Jun 26 10:00:16 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2019 04:31 AM, YueHaibing wrote:
> Fix sparse warning:
> 
> net/core/xdp.c:88:6: warning:
>  symbol '__mem_id_disconnect' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks!
