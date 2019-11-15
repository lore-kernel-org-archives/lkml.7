Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D894FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DB520718
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E94d6+7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfKOQRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:17:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727607AbfKOQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573834652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40njcb1TINFffgelqsMAQtxIER8NlLM+UpDcZ33cw5g=;
        b=E94d6+7wJHaDJn01LkCr2V6thn/j8Qge4BcQMBB6SW8qFCptVqcT/0i6pJDivKX0zbjkB6
        XHjG+ae5plTzHbI793Cm31qQZA0qaXARWlti9x6yJKWSYovMaRi33N2TCkopLx/Ud001l2
        YLkcd1YEewv0tuOJrM8FiwoQbR/wiQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-x79qK2ZyNNC5Sqc9yGdGCQ-1; Fri, 15 Nov 2019 11:17:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B7AE477;
        Fri, 15 Nov 2019 16:17:26 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-92.rdu2.redhat.com [10.10.124.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CBD16764C;
        Fri, 15 Nov 2019 16:17:24 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] x86/speculation: Fix incorrect MDS/TAA mitigation
 status
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20191115161445.30809-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <87378a45-99af-c390-874a-23303e9b70f6@redhat.com>
Date:   Fri, 15 Nov 2019 11:17:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191115161445.30809-1-longman@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: x79qK2ZyNNC5Sqc9yGdGCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 11:14 AM, Waiman Long wrote:
>  v2:
>   - Update the documentation files accordingly
>   - Add an optional second patch to defer printing of MDS mitigation.

Note that I consider the 2nd patch as optional. What is important is the
first one.

Cheers,
Longman


