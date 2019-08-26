Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B615C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C96920828
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfHZPSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:18:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfHZPSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:18:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 757CE1801594;
        Mon, 26 Aug 2019 15:18:15 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 525FD5D9C3;
        Mon, 26 Aug 2019 15:18:10 +0000 (UTC)
Date:   Mon, 26 Aug 2019 10:18:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, ndesaulniers@google.com,
        miguel.ojeda.sandonis@gmail.com, luc.vanoostenryck@gmail.com,
        schwidefsky@de.ibm.com, gregkh@linuxfoundation.org, mst@redhat.com,
        gor@linux.ibm.com, andreyknvl@google.com,
        liuxiaozhou@bytedance.com, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: kernel/bpf/core.o: warning: objtool: ___bpf_prog_run.cold()+0x7:
 call without frame pointer save/setup
Message-ID: <20190826151808.upis57cckcpf2new@treble>
References: <cf0273fb-c272-72be-50f9-b25bb7c7f183@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf0273fb-c272-72be-50f9-b25bb7c7f183@windriver.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Mon, 26 Aug 2019 15:18:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 10:42:53PM +0800, He Zhe wrote:
> Hi All,
> 
> Since 3193c0836f20 ("bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()"),
> We have got the following warning,
> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run.cold()+0x7: call without frame pointer save/setup
> 
> If reverting the above commit, we will get the following warning,
> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x8b9: sibling call from callable instruction with modified stack frame
> if CONFIG_RETPOLINE=n, and no warning if CONFIG_RETPOLINE=y

Can you please share the following:

- core.o file

The following would also be helpful for me to try to recreate it:

- config file
- compiler version
- kernel version

-- 
Josh
