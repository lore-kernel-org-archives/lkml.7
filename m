Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D573C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 09:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E000A2067C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 09:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfFIJWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 05:22:43 -0400
Received: from smtp1.goneo.de ([85.220.129.30]:57532 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfFIJWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 05:22:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 8C61C23FF63;
        Sun,  9 Jun 2019 11:22:39 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D6pB0LIdwmgn; Sun,  9 Jun 2019 11:22:38 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-085-016-227-190.ewe-ip-backbone.de [85.16.227.190])
        by smtp1.goneo.de (Postfix) with ESMTPSA id B273923F220;
        Sun,  9 Jun 2019 11:22:36 +0200 (CEST)
Subject: Re: [PATCH v3 00/33] Convert files to ReST - part 1
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
 <20190609091642.GA3705@osiris>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <56cd597a-9db8-b6ea-eed1-51d3bdf0e6e0@darmarit.de>
Date:   Sun, 9 Jun 2019 11:22:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609091642.GA3705@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 09.06.19 um 11:16 schrieb Heiko Carstens:
> Will there be a web page (e.g. kernel.org), which contains always the
> latest upstream version?

You are looking for the HTML docs on kernel.org?

   https://www.kernel.org/doc/html/latest/

-- Markus --
