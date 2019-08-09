Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0838C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0292089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436860AbfHIPxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436682AbfHIPxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:53:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2028930832DA;
        Fri,  9 Aug 2019 15:53:32 +0000 (UTC)
Received: from treble (ovpn-124-159.rdu2.redhat.com [10.10.124.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5730F60BF3;
        Fri,  9 Aug 2019 15:53:31 +0000 (UTC)
Date:   Fri, 9 Aug 2019 10:53:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [arnd-playground:randconfig-5.3-rc2 32/347]
 fs/reiserfs/prints.o: warning: objtool: __reiserfs_error()+0x80: unreachable
 instruction
Message-ID: <20190809155329.vqbquhjhz25khrgx@treble>
References: <201908090321.bRMBBE6A%lkp@intel.com>
 <CAK8P3a0FT1FCkvik++TJxnp8=36+9EW-tjo0UXdGPZxw_MMPfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0FT1FCkvik++TJxnp8=36+9EW-tjo0UXdGPZxw_MMPfQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 09 Aug 2019 15:53:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:45:34PM +0200, Arnd Bergmann wrote:
> On Thu, Aug 8, 2019 at 9:06 PM kbuild test robot <lkp@intel.com> wrote:
> >
> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/arnd/playground.git randconfig-5.3-rc2
> > head:   bfe9aede7372c8310a9bf31963460c9dd11d1f82
> > commit: 97919a3ec80e9841c4bbac14a80e8b9d482666d4 [32/347] [SUBMITTED 20190718] reiserfs: fix code unwinding with clang
> > config: x86_64-lkp (attached as .config)
> > compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
> > reproduce:
> >         git checkout 97919a3ec80e9841c4bbac14a80e8b9d482666d4
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> fs/reiserfs/namei.o: warning: objtool: entry_points_to_object()+0x117: unreachable instruction
> > --
> > >> fs/reiserfs/do_balan.o: warning: objtool: get_FEB()+0x55: unreachable instruction
> > >> fs/reiserfs/prints.o: warning: objtool: __reiserfs_error()+0x80: unreachable instruction
> > >> fs/reiserfs/lbalance.o: warning: objtool: leaf_move_items()+0x210: unreachable instruction
> > >> fs/reiserfs/fix_node.o: warning: objtool: create_virtual_node()+0x295: unreachable instruction
> > >> fs/reiserfs/inode.o: warning: objtool: reiserfs_update_sd_size()+0x26b: unreachable instruction
> > >> fs/reiserfs/ibalance.o: warning: objtool: balance_internal()+0x30d: unreachable instruction
> > >> fs/reiserfs/stree.o: warning: objtool: reiserfs_cut_from_item()+0x239: unreachable instruction
> > >> fs/reiserfs/tail_conversion.o: warning: objtool: direct2indirect()+0x29c: unreachable instruction
> > >> fs/reiserfs/item_ops.o: warning: objtool: direntry_check_left()+0x5d: unreachable instruction
> > >> fs/reiserfs/journal.o: warning: objtool: flush_commit_list()+0x552: unreachable instruction
> 
> Great fun. The patch I did was my workaround for a related problem with clang,
> see below.
> 
> Josh, is this warning above something you are interested in? I don't
> think it happens in mainline, but it could happen anywhere. I think
> the patch below can be dropped once clang is fixed, but I have so far
> been unable to build a new compiler for testing.

From a brief glance I think you need to remove __reiserfs_panic from
objtool's global_noreturns[] array.

-- 
Josh
