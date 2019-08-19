Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC297C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF9222CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfHSS4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:56:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfHSS4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:56:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB8957F742;
        Mon, 19 Aug 2019 18:56:36 +0000 (UTC)
Received: from gondolin (unknown [10.36.116.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0B6918C70;
        Mon, 19 Aug 2019 18:56:34 +0000 (UTC)
Date:   Mon, 19 Aug 2019 20:56:32 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        freude@de.ibm.com, borntraeger@de.ibm.com,
        pasic@linux.vnet.ibm.com, frankja@linux.ibm.com,
        jjherne@linux.ibm.com
Subject: Re: [PATCH v2] s390: vfio-ap: remove unnecessary calls to disable
 queue interrupts
Message-ID: <20190819205632.54fe2844.cohuck@redhat.com>
In-Reply-To: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
References: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Mon, 19 Aug 2019 18:56:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 13:48:49 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> When an AP queue is reset (zeroized), interrupts are disabled. The queue
> reset function currently tries to disable interrupts unnecessarily. This patch
> removes the unnecessary calls to disable interrupts after queue reset.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
