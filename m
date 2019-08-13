Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5A8C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5A52067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfHMRn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:43:28 -0400
Received: from smtp3.emailarray.com ([65.39.216.17]:54536 "EHLO
        smtp3.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfHMRn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:43:27 -0400
Received: (qmail 98191 invoked by uid 89); 13 Aug 2019 17:36:47 -0000
Received: from unknown (HELO ?172.20.41.143?) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTk5LjIwMS42NC4xMzc=) (POLARISLOCAL)  
  by smtp3.emailarray.com with (AES256-GCM-SHA384 encrypted) SMTP; 13 Aug 2019 17:36:47 -0000
From:   "Jonathan Lemon" <jlemon@flugsvamp.com>
To:     "Ivan Khoronzhuk" <ivan.khoronzhuk@linaro.org>
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        jakub.kicinski@netronome.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] libbpf: add asm/unistd.h to xsk to get
 __NR_mmap2
Date:   Tue, 13 Aug 2019 10:36:42 -0700
X-Mailer: MailMate (1.12.5r5635)
Message-ID: <12D743F3-6BA0-4D9D-A80D-613EB0F86816@flugsvamp.com>
In-Reply-To: <20190813102318.5521-2-ivan.khoronzhuk@linaro.org>
References: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
 <20190813102318.5521-2-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 Aug 2019, at 3:23, Ivan Khoronzhuk wrote:

> That's needed to get __NR_mmap2 when mmap2 syscall is used.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
