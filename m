Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF865218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbfCVMqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:46:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40894 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387473AbfCVMqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:46:16 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7JYf-0007OQ-4c; Fri, 22 Mar 2019 13:46:01 +0100
Date:   Fri, 22 Mar 2019 13:46:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] b/arch/x86/mm/pti.c - make local symbols static
In-Reply-To: <27680.1552376873@turing-police>
Message-ID: <alpine.DEB.2.21.1903221342530.1729@nanos.tec.linutronix.de>
References: <27680.1552376873@turing-police>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1457285186-1553258761=:1729"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1457285186-1553258761=:1729
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Valdis,

On Tue, 12 Mar 2019, Valdis Klētnieks wrote:

I've applied the lot, but I had to fixup the subject lines.

# git log path/to/file

gives you a decent hint on what the usual prefix and format is.

 'b/arch/x86/mm/pti.c -'

is obviously not.

Thanks,

	tglx
--8323329-1457285186-1553258761=:1729--
