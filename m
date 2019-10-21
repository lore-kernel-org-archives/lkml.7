Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCC9CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8121205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfJUTcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:32:52 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:44375 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728056AbfJUTcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:32:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1505D18224089;
        Mon, 21 Oct 2019 19:32:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: deer20_35a6d87dcf03f
X-Filterd-Recvd-Size: 1851
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 21 Oct 2019 19:32:48 +0000 (UTC)
Message-ID: <16d819ded0c1edb46af8914a26cad479aac176e9.camel@perches.com>
Subject: Re: linux-next: Fixes tag needs some work in the rdma-fixes tree
From:   Joe Perches <joe@perches.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Matteo Croce <mcroce@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Date:   Mon, 21 Oct 2019 12:32:47 -0700
In-Reply-To: <20191021173921.GD6285@mellanox.com>
References: <20191021184128.601ff09d@canb.auug.org.au>
         <c4377d50c8a30ae292cd7886909238ce4fb56ee5.camel@redhat.com>
         <20191021151507.GD25164@mellanox.com>
         <CAGnkfhzCuCUBG++QRTZbsUyFr8orq059Be7AvyL+_V9Smz7J3g@mail.gmail.com>
         <20191021170111.GB6285@mellanox.com>
         <CAGnkfhwsczOBLMZSJ0pWm=L3bMqgd4mWNitpZB3-NwjFN+fYDA@mail.gmail.com>
         <20191021171153.GC6285@mellanox.com>
         <d3a389360982c9d2730e6b29eb96523a562483ac.camel@perches.com>
         <20191021173921.GD6285@mellanox.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-21 at 17:39 +0000, Jason Gunthorpe wrote:
> Maybe output format and then parse it to check the min
> length and verify the subject?

I'm not too worried about that for now.
12 should still be good for quite awhile...

$ git log --abbrev=1 --format='%h' --no-merges  | \
  awk '{print length($1);}' | sort -n | uniq -c
     90 5
 463746 6
 320183 7
  26244 8
   1683 9
    118 10
      6 11


