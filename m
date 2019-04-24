Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4185C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDB820878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfDXXDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:03:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55955 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfDXXDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:03:22 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJQFl-0007hQ-NI; Thu, 25 Apr 2019 00:20:33 +0200
Date:   Thu, 25 Apr 2019 00:20:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de
Subject: Re: [RFC PATCH v5 0/4] x86: Add the support of ACRN guest under
 x86
In-Reply-To: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
Message-ID: <alpine.DEB.2.21.1904250020140.1762@nanos.tec.linutronix.de>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
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

On Wed, 24 Apr 2019, Zhao Yakui wrote:

> ACRN is a flexible, lightweight reference hypervisor, built with real-time
> and safety-criticality in mind, optimized to streamline embedded development
> through an open source platform. It is built for embedded IOT with small
> footprint and real-time features. More details can be found
> in https://projectacrn.org/
> 
> This is the patch set that allows the Linux to work on ACRN hypervisor and it can
> work with the following patch set to manage the Linux guest on ACRN hypervisor. It
> includes the detection of ACRN hypervisor, upcall notification vector from
> hypervisor, hypercall. The hypervisor detection is similar to Xen/VMWARE/Hyperv.
> ACRN also uses the upcall notification mechanism similar to that in Xen/Microsoft
> HyperV when it needs to send the notification to Linux OS. The hypercall provides
> the mechanism that can be used to query/configure the ACRN hypervisor by Linux guest.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
