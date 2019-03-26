Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34C2C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B805C2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfCZLhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:37:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:11902 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730722AbfCZLh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:37:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 04:37:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="137361552"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.182])
  by orsmga003.jf.intel.com with ESMTP; 26 Mar 2019 04:37:25 -0700
Date:   Tue, 26 Mar 2019 13:37:25 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Mimi Zohar <zohar@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Denis Kenzior <denkenz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        James Morris <james.morris@microsoft.com>
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
Message-ID: <20190326113725.GA10898@linux.intel.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212705.26837-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325212705.26837-1-joe@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi,

Can you fix this and I can ack and send PR through my tree?

/Jarkko

On Mon, Mar 25, 2019 at 02:27:05PM -0700, Joe Perches wrote:
> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.
> 
> This could occur because a matching filename was never added, was deleted
> or renamed in some other commit.
> 
> The commits that added and if found renamed or removed the file pattern
> are shown below.
> 
> Please fix this defect appropriately.
> 
> 1: ---------------------------------------------------------------------------
> 
> linux-next MAINTAINERS section:
> 
> 	8587	KEYS-TRUSTED
> 	8588	M:	James Bottomley <jejb@linux.ibm.com>
> 	8589	M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 	8590	M:	Mimi Zohar <zohar@linux.ibm.com>
> 	8591	L:	linux-integrity@vger.kernel.org
> 	8592	L:	keyrings@vger.kernel.org
> 	8593	S:	Supported
> 	8594	F:	Documentation/security/keys/trusted-encrypted.rst
> 	8595	F:	include/keys/trusted-type.h
> 	8596	F:	security/keys/trusted.c
> -->	8597	F:	security/keys/trusted.h
> 
> 2: ---------------------------------------------------------------------------
> 
> The most recent commit that added or modified file pattern 'security/keys/trusted.h':
> 
> commit 7f3c68bee977ab872827e44de017216736fe21d7
> Author: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Date:   Tue Jan 18 09:07:13 2011 -0500
> 
>     keys: add trusted and encrypted maintainers
>     
>     Add myself and David Safford as maintainers for trusted/encrypted keys.
>     
>     Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
>     Acked-by: David Howells <dhowells@redhat.com>
>     Signed-off-by: James Morris <jmorris@namei.org>
> 
>  MAINTAINERS | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> 3: ---------------------------------------------------------------------------
> 
> The last commit with a real presence of file pattern 'security/keys/trusted.h':
> 
> commit 22447981fc050b5f1bdd0e7cbee89b4152a2b2d8
> Author: Denis Kenzior <denkenz@gmail.com>
> Date:   Tue Oct 9 17:48:49 2018 +0100
> 
>     KEYS: Move trusted.h to include/keys [ver #2]
>     
>     Signed-off-by: Denis Kenzior <denkenz@gmail.com>
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     Tested-by: Marcel Holtmann <marcel@holtmann.org>
>     Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
>     Signed-off-by: James Morris <james.morris@microsoft.com>
> 
>  {security => include}/keys/trusted.h | 0
>  security/keys/trusted.c              | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
