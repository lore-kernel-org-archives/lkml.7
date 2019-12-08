Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09942C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2B0206F4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 07:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfLHHLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 02:11:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:58441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfLHHLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 02:11:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2019 23:11:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,291,1571727600"; 
   d="gz'50?scan'50,208,50";a="219755148"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2019 23:11:08 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1idqih-000BGw-Oo; Sun, 08 Dec 2019 15:11:07 +0800
Date:   Sun, 8 Dec 2019 15:10:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     kbuild-all@lists.01.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v5 03/10] perf: Use min_max_heap in visit_groups_merge
Message-ID: <201912081358.nGnfuWkq%lkp@intel.com>
References: <20191206231539.227585-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xxzwvvtd5gq3a7so"
Content-Disposition: inline
In-Reply-To: <20191206231539.227585-4-irogers@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xxzwvvtd5gq3a7so
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[cannot apply to tip/auto-latest linus/master v5.4 next-20191206]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Ian-Rogers/Optimize-cgroup-context-switch/20191208-065350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ceb9e77324fa661b1001a0ae66f061b5fcb4e4e6
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

Note: the linux-review/Ian-Rogers/Optimize-cgroup-context-switch/20191208-065350 HEAD 90f4b194c2271d12b02888811e887a869d1e3817 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> kernel/events/core.c:52:10: fatal error: linux/min_max_heap.h: No such file or directory
    #include <linux/min_max_heap.h>
             ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +52 kernel/events/core.c

  > 52	#include <linux/min_max_heap.h>
    53	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--xxzwvvtd5gq3a7so
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--xxzwvvtd5gq3a7so--
