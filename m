Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA53C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD2320868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfDPI67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:58:59 -0400
Received: from www62.your-server.de ([213.133.104.62]:36718 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPI66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:58:58 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJUV-0006Px-2z; Tue, 16 Apr 2019 10:30:55 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJUU-000XLN-Sn; Tue, 16 Apr 2019 10:30:54 +0200
Subject: Re: [PATCH bpf-next v1] bpf: add map helper functions push,pop,peek
 in more BPF programs
To:     Alban Crequy <alban.crequy@gmail.com>, ast@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io,
        Mauricio Vasquez B <mauricio.vasquez@polito.it>
References: <20190414165846.22107-1-alban@kinvolk.io>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5bf30342-319d-5c3d-3b6b-1156627cdfcc@iogearbox.net>
Date:   Tue, 16 Apr 2019 10:30:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190414165846.22107-1-alban@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25420/Mon Apr 15 09:57:25 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/2019 06:58 PM, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
> 
> commit f1a2e44a3aec ("bpf: add queue and stack maps") introduced new BPF
> helper functions:
> - BPF_FUNC_map_push_elem
> - BPF_FUNC_map_pop_elem
> - BPF_FUNC_map_peek_elem
> 
> but they were made available only for network BPF programs. This patch
> makes them available for tracepoint, cgroup and lirc programs.
> 
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> Cc: Mauricio Vasquez B <mauricio.vasquez@polito.it>

Applied, thanks!
