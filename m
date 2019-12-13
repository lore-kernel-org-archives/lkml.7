Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FDCC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946A82253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbfLMFkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:40:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59132 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMFkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:40:33 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifdgm-0003hv-5h; Fri, 13 Dec 2019 05:40:32 +0000
Date:   Fri, 13 Dec 2019 05:40:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: list_del corruption when running ndctl with linux next
Message-ID: <20191213054032.GM4203@ZenIV.linux.org.uk>
References: <20191213053442.GB31115@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213053442.GB31115@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 09:34:43PM -0800, Ira Weiny wrote:
> Running this on linux-next from 11 Dec on qemu:

Check -next from Dec 12; should be fixed there.
