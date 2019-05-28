Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E606DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D8520989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfE1STN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:19:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfE1STM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:19:12 -0400
Received: from 50-233-100-202-static.hfc.comcastbusiness.net ([50.233.100.202] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hVggb-0004zU-Ih; Tue, 28 May 2019 20:18:58 +0200
Date:   Tue, 28 May 2019 11:18:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Subject: Re: [REVIEW][PATCH 11/26] signal/x86: Remove task parameter from
 send_sigtrap
In-Reply-To: <20190523003916.20726-12-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1905281118290.1859@nanos.tec.linutronix.de>
References: <20190523003916.20726-1-ebiederm@xmission.com> <20190523003916.20726-12-ebiederm@xmission.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Eric W. Biederman wrote:

> The send_sigtrap function is always called with task == current.  Make
> that explicit by removing the task parameter.
> 
> This also makes it clear that the x86 send_sigtrap passes current
> into force_sig_fault.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

