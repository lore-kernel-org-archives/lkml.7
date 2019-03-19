Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7301C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B508F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="2MsdGFq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfCSID6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:03:58 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:56640 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfCSID5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:03:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 5B8811777;
        Tue, 19 Mar 2019 09:03:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1552982634; x=1554797035; bh=C0kgbeYzb5O49IVYGePSDb6/Gaxsox0RhH5
        LjlZcmgE=; b=2MsdGFq9dUE3R/qZT0BPM92s8yyXmic6VBVpTChuHl5V7mW4r5M
        bSfuJW9lqfc9XyJAFQgjMpWeVRXP9U932Qd4BH+s8LEiGwLTPS6h9jttWTVw05Ic
        ZuWokcs4WtbhL2q8wkx39uJlRcI+9Q8wJXTZ+xbr6n9vnBj4V+toIXNY1hYaEGV3
        f9KJZBGLsVv23Bz9x7tip31o12Su8sjfT6Xx3ORk1N8ptFB+98Ya9RmWKNlA/WJe
        bIwAi6yXMLcvabdIODJlBTqUylOpt2TPXQTyVN0Jpi2RNpNmVIqcJNG1LFERbzqR
        PIHH7OJpN5oMPVczAV5L28eZr+S3IgqhVvA4brAfM6UxDmp1i6bKjTfu1cUOivgs
        K22L/BEp93AuV6AvYzCbt1UefjzumzhAqo2MfozW6qkdUIt9uNWdApZTFNX0eRGy
        lgvUi7HIvz0jgMC8gwdID1S4CDGSBcwmQWcNY7HA2wH2Kp/C9JPTjk5eN45gXxDs
        sXI1A6dpV8zmgdOcl5RUDe1Ce3aUAUyEvWweZ5aDImBzW1AXl1ShFT/WNukjfbgS
        6L+RtRRWhcvsaJueqUfIlqIe9pfQUFg8JVOz+4vNcXwUr3nps7SA5rzR7Dyi4XsI
        sHQ2tzMK9A/XjyeYX9kYwxVpyFk16aZThILe0R5VVvLPm6uIFSQBu3tc=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pcUpff5qMI8c; Tue, 19 Mar 2019 09:03:54 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id D58261776;
        Tue, 19 Mar 2019 09:03:54 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id B39E72757;
        Tue, 19 Mar 2019 09:03:54 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: add translation disclaimer
Date:   Tue, 19 Mar 2019 09:03:53 +0100
Message-ID: <14381941.zoZXB8H0OD@pcbe13614>
In-Reply-To: <20190318113534.43fb94f3@lwn.net>
References: <20190314204516.10890-1-federico.vaga@vaga.pv.it> <20190318113534.43fb94f3@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 18, 2019 6:35:34 PM CET Jonathan Corbet wrote:
> On Thu, 14 Mar 2019 21:45:16 +0100
> 
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > Add the translation disclaimer in English as reference
> > for other languages.  Translations must include this disclaimer
> > in their language so that readers are properly informed.
> > 
> > This very same patch updates the Italian translation accordingly.
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> 
> Honestly, it all feels a little too legalistic to me; have people been
> worried about the translations in this regard?
> 
> Oh well, I went ahead and applied it.  I do think that it might make sense
> to move the TOC *above* the disclaimer, though, since that's what readers
> are really going to be interested in.

No, problem I can do it and send a new version

> 
> Thanks,
> 
> jon


-- 
Federico Vaga
http://www.federicovaga.it/


