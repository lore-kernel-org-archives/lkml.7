Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A0EC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC662077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfHPUvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:51:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfHPUvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:51:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD16B3086208;
        Fri, 16 Aug 2019 20:51:01 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F3EF10016EB;
        Fri, 16 Aug 2019 20:51:01 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] libnvdimm/security: Consolidate 'security' operations
References: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
        <156583202899.2815870.9164783407864995953.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 16 Aug 2019 16:51:00 -0400
In-Reply-To: <156583202899.2815870.9164783407864995953.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Wed, 14 Aug 2019 18:20:29 -0700")
Message-ID: <x49v9uwbzrf.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 16 Aug 2019 20:51:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> The security operations are exported from libnvdimm/security.c to
> libnvdimm/dimm_devs.c, and libnvdimm/security.c is optionally compiled
> based on the CONFIG_NVDIMM_KEYS config symbol.
>
> Rather than export the operations across compile objects, just move the
> __security_store() entry point to live with the helpers.
>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Fine by me.

Acked-by: Jeff Moyer <jmoyer@redhat.com>

