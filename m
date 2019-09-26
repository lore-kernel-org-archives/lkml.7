Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16579C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E928B222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfIZItC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:49:02 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:36840 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbfIZItB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:49:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9BFBB9079;
        Thu, 26 Sep 2019 08:49:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shop50_6b6c133c79719
X-Filterd-Recvd-Size: 1340
Received: from XPS-9350 (unknown [172.58.27.131])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Sep 2019 08:48:57 +0000 (UTC)
Message-ID: <698e9c5310003fb71dcc7e5b096c8a415c86cc8c.camel@perches.com>
Subject: Re: [PATCH v2] scripts: Move ipc/ to kernel/ipc/: don't check the
 ipc dir
From:   Joe Perches <joe@perches.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>, apw@canonical.com,
        mingo@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 26 Sep 2019 01:48:27 -0700
In-Reply-To: <bd70558e-5126-6460-81d7-edf72cbbce7a@huawei.com>
References: <bd70558e-5126-6460-81d7-edf72cbbce7a@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-26 at 09:26 +0800, Yunfeng Ye wrote:
> After the commit 76128326f97c ("toplevel: Move ipc/ to kernel/ipc/: move
> the files"), we met some error messages:
> 
>   ./scripts/checkpatch.pl:
>   "Must be run from the top-level dir. of a kernel tree"
> 
>   ./scripts/get_maintainer.pl:
>   "The current directory does not appear to be a linux kernel source tree.
> 
> Don't check the ipc dir in checkpatch.pl and get_maintainer.pl.

Thanks.


