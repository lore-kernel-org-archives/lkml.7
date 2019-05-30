Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F2DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA8825BBD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559227986;
	bh=hSvO5ISBULPkbviI2yZeC2rbY+FDFr8e4DfuyNFkTtA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SZ58CBu8h1HiTZ5KM6bxSYMlFaTmy1qxXXtgptgG2oCPUAw0fGuUtQbS3CPl2eGVC
	 eNEI+JEQQAqhcGtljz42yXhbH0Yyr4b1dBsY8ltXn/ihtWkE7f+/tm3dEIK0vaNlHe
	 tnTYaOZQ5pSxd10sv6XOBE0GfALLW2qiJKw1Cbno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfE3OxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfE3OxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:53:04 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F55925BBD;
        Thu, 30 May 2019 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559227983;
        bh=hSvO5ISBULPkbviI2yZeC2rbY+FDFr8e4DfuyNFkTtA=;
        h=From:To:Cc:Subject:Date:From;
        b=Ox5gXAdgNOsgRenvTeoe2DHlne5jvjXccLrHeEP9KkZCXWN7LJuUIoQZ2PPRN1bYK
         ASEZXvZiogKCADZzJYDvuDeFzrYCq3ni7DB3NieE0ohRx3tC0lSF5ouEYwLbxD1f3Q
         9gkqtONkADgT8csI3v/b1i18e2l9WOuzNE6ivXhk=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 0/1] one fix for FPGA
Date:   Thu, 30 May 2019 09:52:58 -0500
Message-Id: <20190530145259.4189-1-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please take this FPGA fix.  It have been reviewed on
the mailing list and applies cleanly on current
linux-next and char-misc-testing.

Thanks,
Alan

Moritz Fischer (1):
  fpga: zynqmp-fpga: Correctly handle error pointer

 drivers/fpga/zynqmp-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.21.0

