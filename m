Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAEEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59F02183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbfDXV1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:27:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55838 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733182AbfDXV1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:27:12 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJPPz-0007DW-P5; Wed, 24 Apr 2019 23:27:03 +0200
Date:   Wed, 24 Apr 2019 23:27:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.li@linux.intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v17 3/3] Documentation/filesystems/proc.txt: add arch_status
 file
In-Reply-To: <20190421183529.9141-3-aubrey.li@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1904242320101.1762@nanos.tec.linutronix.de>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com> <20190421183529.9141-3-aubrey.li@linux.intel.com>
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

On Mon, 22 Apr 2019, Aubrey Li wrote:
> +3.12 /proc/<pid>/arch_status - task architecture specific status
> +-------------------------------------------------------------------
> +When CONFIG_PROC_PID_ARCH_STATUS is enabled, this file displays the
> +architecture specific status of the task.
> +
> +Example
> +-------
> + $ cat /proc/6753/arch_status
> + AVX512_elapsed_ms:      8

Examples are nice, but as this is architecture specific this section needs
to list the entries which are exposed by a particular architecture.

x86 specific entries:
---------------------

  AVX512_elapsed_ms:
  ------------------
     If AVX512 is supported ....

Thanks,

	tglx
