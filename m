Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD6C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD242075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfHESNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:13:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40070 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfHESNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:13:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1huhTb-0007sZ-Cd; Mon, 05 Aug 2019 18:12:55 +0000
Date:   Mon, 5 Aug 2019 19:12:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] i915: convert to new mount API
Message-ID: <20190805181255.GH1131@ZenIV.linux.org.uk>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
 <20190805160307.5418-3-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805160307.5418-3-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 01:03:06AM +0900, Sergey Senozhatsky wrote:
> tmpfs does not set ->remount_fs() anymore and its users need
> to be converted to new mount API.

Could you explain why the devil do you bother with remount at all?
Why not pass the right options when mounting the damn thing?
