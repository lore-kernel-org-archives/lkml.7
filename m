Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A418C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5127E22500
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfI3Upn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:45:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37975 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbfI3Upn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:45:43 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iF2CW-0008M5-Hl; Mon, 30 Sep 2019 20:23:20 +0000
Date:   Mon, 30 Sep 2019 22:23:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martijn Coenen <maco@android.com>,
        Todd Kjos <tkjos@android.com>
Subject: Re: [PATCH] binder: Fix comment headers on
 binder_alloc_prepare_to_free()
Message-ID: <20190930202319.vy424fbi4szkvysd@wittgenstein>
References: <20190930201250.139554-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190930201250.139554-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 04:12:50PM -0400, Joel Fernandes wrote:
> binder_alloc_buffer_lookup() doesn't exist and is named
> "binder_alloc_prepare_to_free()". Correct the code comments to reflect
> this.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
