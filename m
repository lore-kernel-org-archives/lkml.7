Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579BEC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1818321A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="jAIVAosE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfKETuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:50:37 -0500
Received: from cmta20.telus.net ([209.171.16.93]:51694 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfKETug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:50:36 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id S4qTikm1RN5I9S4qYiD07o; Tue, 05 Nov 2019 12:50:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1572983435; bh=D+RqI+3/jpH1/vNrsBZKNgb7cWXfOudFb9ZqsgT0Weg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=jAIVAosEkZYOTkMt5vAIdUinLb1VExFYQCQCstnEWd0a7kQxZxfNo1+8uymTRzFjE
         vmlpb8nAa+pzKPDPBfaVK/nbAUZK0rB7Y53F5+4GrNhxehHAbYNcs8SZgytgvxXnJp
         faqZzkc+dYg92AxupiDNPLrK3CeIVuw1n1aKjU5Y/lUakbVoF7OtCU2MGTj8zhmgQM
         78vxJqh9yPQdI4nkHQ71CTC2oSzUT661c8DStRXqT4WADO0rWBXgLomHxU54WoluZk
         ctLg9P22RAEkyq939h91sRVLV8ApYwvZ70lZLHKMOMqmxGCfY+gGmqrk+0cHnHXtrI
         4+IUsL1RwpP4w==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=aatUQebYAAAA:8 a=IOzfGkCk6AO6b-NIX_0A:9
 a=CjuIK1q_8ugA:10 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>
References: <60416800.X4hXmAfbqi@kreacher> <5976014.dk64zBpnPU@kreacher>
In-Reply-To: <5976014.dk64zBpnPU@kreacher>
Subject: RE: [PATCH 2/4] cpuidle: teo: Rename local variable in teo_select()
Date:   Tue, 5 Nov 2019 11:50:32 -0800
Message-ID: <001501d59412$490a9490$db1fbdb0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdV/snrkfmAtLZE1Tc+M01gnPwzw5wUXbGNQ
X-CMAE-Envelope: MS4wfLnaYBIVqGmgqGwfmpsVFYE9GNCMIpePgbnwXlEFdBg69IirwdS9aj9rNDV9YUCAAqJ4tSRvNbF1iJ8JrMVxL76fgPGv3vgL/Y8RkDk5vKHPeWpVm28h
 Mk63AtFpQs/cQ/YRF9MuxMV2OnFQZwAlpfCkL0lmQ6Rdk0iftMbkHW6dDqLYnoVNyNszat8vXo+MifZaOKA2AKhX+rfq1xhSbtXL4HuA+huIdUBhXQ9Gum4q
 8zzU19zL8quQl2lzPH0AX0i3cu2+tRliMCFl47yMIu4RX4VxZi5PDqp41cynJ3aqiRYJ7ypW3W27Ci8FgC7xopxUfpF2TZmacPUZbI7njdYlqAU2tsGFCJMc
 gaqJEq3P
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019.10.10 14:33 Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Rename a local variable in teo_select() in preparation for subsequent
> code modifications, no intentional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This change makes it easier to read and understand.
Thanks.

Acked-by: Doug Smythies <dsmythies@telus.net>


