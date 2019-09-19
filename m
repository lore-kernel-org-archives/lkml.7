Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB8CC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E142196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389308AbfISKZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:25:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389206AbfISKZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:25:55 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46YtKX0lTNz9sPh; Thu, 19 Sep 2019 20:25:51 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a3db31ff6ce31f5a544a66b61613a098029031cc
In-Reply-To: <8f6f14d192a994008ac370ce14036bbe67224c7d.1567707399.git.naveen.n.rao@linux.vnet.ibm.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/3] ftrace: Look up the address of return_to_handler() using helpers
Message-Id: <46YtKX0lTNz9sPh@ozlabs.org>
Date:   Thu, 19 Sep 2019 20:25:51 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-05 at 18:20:28 UTC, "Naveen N. Rao" wrote:
> This ensures that we use the right address on architectures that use
> function descriptors.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a3db31ff6ce31f5a544a66b61613a098029031cc

cheers
