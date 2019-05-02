Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E16C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E77D20651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEBIOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:14:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:56450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbfEBIOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:14:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7BA59ABE7;
        Thu,  2 May 2019 08:14:34 +0000 (UTC)
Date:   Thu, 2 May 2019 10:12:16 +0200
From:   Michal Rostecki <mrostecki@opensuse.org>
To:     Y Song <ys114321@gmail.com>
Cc:     Michal Rostecki <mrostecki@opensuse.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf, libbpf: Add .so files to gitignore
Message-ID: <20190502081215.pgolgoucdlnlgzui@workstation>
References: <20190430162501.13256-1-mrostecki@opensuse.org>
 <20190430172701.jegv3tmcvo3ytdri@workstation>
 <CAH3MdRUuK7nuT=OG+68WLiq1ne8nY0x6WVYGDv_xsvZNNd58sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH3MdRUuK7nuT=OG+68WLiq1ne8nY0x6WVYGDv_xsvZNNd58sQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 02:08:35PM -0700, Y Song wrote:
> On Tue, Apr 30, 2019 at 10:28 AM Michal Rostecki <mrostecki@opensuse.org> wrote:
> >
> > I forgot to add "bpf-next" to the subject prefix, sorry!
> 
> Maybe you can submit a v2 of this patch with my ack below so the patch
> can be easily applied without tweaking?
> Acked-by: Yonghong Song <yhs@fb.com>

Sure, I will do it now.
