Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EAAC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208B320883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDIRPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:15:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:48545 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbfDIRPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:15:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 10:15:01 -0700
X-IronPort-AV: E=Sophos;i="5.60,330,1549958400"; 
   d="scan'208";a="132815840"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.200.224]) ([10.254.200.224])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 09 Apr 2019 10:15:00 -0700
Subject: Re: [RFC PATCH 31/68] vfs: Convert qib_fs/ipathfs to use the new
 mount API
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
 <155373026764.7602.420612273283807556.stgit@warthog.procyon.org.uk>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <9fd8642b-952b-7ed6-6543-fe3f35b504ca@intel.com>
Date:   Tue, 9 Apr 2019 13:14:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155373026764.7602.420612273283807556.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/2019 7:44 PM, David Howells wrote:
> Convert the qib_fs/ipathfs filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
> 
> See Documentation/filesystems/mount_api.txt for more information.
> 
> [Q] Can qib_remove() race with qibfs_kill_super()?  Should qib_super
>      accesses be serialised with some sort of lock?

Sure looks to be possible to me. Although I don't think that's a reason 
not to apply your patch, you aren't making it any worse I don't think.

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> cc: linux-rdma@vger.kernel.org

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
