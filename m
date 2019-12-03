Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64173C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E39420661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfLCJDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:03:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:46668 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCJDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:03:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 01:03:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="412112040"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga006.fm.intel.com with ESMTP; 03 Dec 2019 01:03:20 -0800
Subject: Re: [kbuild-all] Re: [PATCH next 2/3] debugfs: introduce
 debugfs_create_single[,_data]
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20191203083847.GC1787@kadam>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <06d63c3c-bab5-c19e-a51d-ac7c1ed0a80c@intel.com>
Date:   Tue, 3 Dec 2019 17:02:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191203083847.GC1787@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/19 4:38 PM, Dan Carpenter wrote:
> [ How do I fetch 0day git branchs?
>    git fetch https://github.com/0day-ci/linux/commits/Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440
>    doesn't work. - dan ]

Hi Dan,

I can fetch it by the following steps:

nfs@shao2-debian:~/linux$ git remote add 0day-linux-review 
https://github.com/0day-ci/linux.git
nfs@shao2-debian:~/linux$ git fetch --no-tags 0day-linux-review 
Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440 

remote: Enumerating objects: 25261, done.
remote: Counting objects: 100% (25261/25261), done.
remote: Total 33246 (delta 25260), reused 25260 (delta 25260), 
pack-reused 7985
Receiving objects: 100% (33246/33246), 12.03 MiB | 1.05 MiB/s, done.
Resolving deltas: 100% (28148/28148), completed with 6149 local objects.
 From https://github.com/0day-ci/linux
  * branch 
Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440 
-> FETCH_HEAD
  * [new branch] 
Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440 
-> 
0day-linux-review/Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440

Best Regards,
Rong Chen

>
> Hi Kefeng,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on next-20191128]
> [cannot apply to v5.4]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Kefeng-Wang/debugfs-introduce-debugfs_create_single-seq-_data/20191129-173440
> base:    d26b0e226f222c22c3b7e9d16e5b886e7c51057a
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> New smatch warnings:
> fs/debugfs/file.c:1193 debugfs_create_single_data() warn: overwrite may leak 'entry'
>
> Old smatch warnings:
> include/linux/compiler.h:247 __write_once_size() warn: potential memory corrupting cast 8 vs 4 bytes
>
> # https://github.com/0day-ci/linux/commit/198a4ea9768d6790a169e8b802e702c208aafbd1
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 198a4ea9768d6790a169e8b802e702c208aafbd1
> vim +/entry +1193 fs/debugfs/file.c
>
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1179  struct dentry *debugfs_create_single_data(const char *name, umode_t mode,
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1180  					  struct dentry *parent, void *data,
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1181  					  int (*read_fn)(struct seq_file *s,
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1182  							 void *data))
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1183  {
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1184  	struct debugfs_entry *entry;
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1185
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1186  	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1187  	if (!entry)
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1188  		return ERR_PTR(-ENOMEM);
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1189
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1190  	entry->read = read_fn;
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1191  	entry->data = data;
> 198a4ea9768d67 Kefeng Wang      2019-11-29  1192
> 198a4ea9768d67 Kefeng Wang      2019-11-29 @1193  	entry = debugfs_set_lowest_bit(entry);
>                                                          ^^^^^^^^
> I haven't looked at the surrounding code but how would we free "entry"
> when we write over it here?
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

