Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D58C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F4E20857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfCKOvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:51:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:55768 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfCKOvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:51:05 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D50E42D9;
        Mon, 11 Mar 2019 14:51:04 +0000 (UTC)
Date:   Mon, 11 Mar 2019 08:51:03 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Weiwei Jia <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Coly Li <colyli@suse.de>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v3 00/31] clean up and reorg Chinese kernel docs
Message-ID: <20190311085103.566ebac0@lwn.net>
In-Reply-To: <fb2090f4-5b80-c3f3-5cfa-1115dcd0e1ec@linux.alibaba.com>
References: <20190308030918.22337-1-alex.shi@linux.alibaba.com>
        <13549ad2-6a3e-5bc3-9e47-3e20fd720fd8@linux.alibaba.com>
        <CAD+1EGP01hsT_h+XDiyFqon9k4J0rvyYVwdbOQo7qXOmAOmL+g@mail.gmail.com>
        <fb2090f4-5b80-c3f3-5cfa-1115dcd0e1ec@linux.alibaba.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 14:31:08 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> What's the normal process of the Chinese kernel doc pick up? Will you
> send a pull request to Corbet? or Corbet pick it them with your comment?

Please repost the series with acks and comments applied - preferably after
the close of the merge window - and I'll apply them then.

Thanks,

jon
