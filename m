Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A571C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20640206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfCHXAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:00:43 -0500
Received: from namei.org ([65.99.196.166]:56194 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfCHXAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:00:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x28N0cn0012822;
        Fri, 8 Mar 2019 23:00:38 GMT
Date:   Sat, 9 Mar 2019 10:00:38 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH 03/27] Enforce module signatures if the kernel is locked
 down
In-Reply-To: <20190306235913.6631-4-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1903090959210.12052@namei.org>
References: <20190306235913.6631-1-matthewgarrett@google.com> <20190306235913.6631-4-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019, Matthew Garrett wrote:

> From: David Howells <dhowells@redhat.com>
> 
> If the kernel is locked down, require that all modules have valid
> signatures that we can verify.

Perhaps note that this won't cover the case where folk are using DM-Verity 
with a signed root hash for verifying kernel modules.


-- 
James Morris
<jmorris@namei.org>

