Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4032EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FF120883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oHClgA+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfDAMMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:12:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37453 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfDAMMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:12:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190401121238euoutp02d23c63792aa5b4ab51703eba6b046dcc~RWJiUxZTP2060020600euoutp02S
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 12:12:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190401121238euoutp02d23c63792aa5b4ab51703eba6b046dcc~RWJiUxZTP2060020600euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554120758;
        bh=oUO9xhoPeweJNJyFGq/LpHLoZ6yMo8TTgO6O2aPOemE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oHClgA+rjljSmgzbIJcsJP4mOTvHmX1Q2dQsttpey2tt4v/ol0d5rsGMMSWMwhIes
         SGupavQAwJZKrr826FRJE9nBP2O88kxBYzQcIqYrQ1dAL6G+sTT+uNj3goND0QJWnJ
         ZfsqylIqsjpJOeM5K9mHVLD2Ycl3SFxkwA+dgl+E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401121237eucas1p29c6ec77ebccd449491833092d282e43e~RWJhe360z0787207872eucas1p2N;
        Mon,  1 Apr 2019 12:12:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 13.8D.04377.53002AC5; Mon,  1
        Apr 2019 13:12:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190401121237eucas1p262ff4e0c45fe5fc6ea8831ea0371cf7c~RWJgvkUnD0785907859eucas1p2K;
        Mon,  1 Apr 2019 12:12:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190401121236eusmtrp19f1182968cea11dd7addc53b2ddde4a7~RWJghf6xM1791717917eusmtrp1y;
        Mon,  1 Apr 2019 12:12:36 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-ac-5ca2003598e6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9E.4B.04146.43002AC5; Mon,  1
        Apr 2019 13:12:36 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190401121236eusmtip242d333576929875d3f42023d0d1b1be8~RWJgMEm222730827308eusmtip2h;
        Mon,  1 Apr 2019 12:12:36 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: atmel_lcdfb: drop AVR and platform_data
 support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d0c51868-dc4a-9494-a7f6-287a4ff605e1@samsung.com>
Date:   Mon, 1 Apr 2019 14:12:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190225212533.26432-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87qmDItiDP48UrFof7eM3eLK1/ds
        FpseX2O1ONH3gdXi8q45bBbbNy9ktljxcyujA7vHvDXVHve7jzN5bF5S73Hnx1JGjyXTrrJ5
        fN4kF8AWxWWTkpqTWZZapG+XwJXxs+M5W8FvpopFnUtYGhi3MXUxcnJICJhITL/wkLmLkYtD
        SGAFo8TpMytYQBJCAl8YJbb/U4OwPzNKnPseC9PwdfcWJoiG5YwSvXc3QjlvGSU+rX/AClIl
        LBAi8evJabBJIgKmEq2Nu9hAipgFbjBKrL+yB2w3m4CVxMT2VYwgNq+AncT6PduZQWwWARWJ
        j/+3AjVwcIgKREj0n1GHKBGUODnzCdhMTgFniYX32sDGMAsYSBxZNIcVwpaX2P52Dtg7EgKr
        2CXu3/nJCnG2i8Tj2x3sELawxKvjW6BsGYnTk3tYIBrWMUr87XgB1b2dUWL55H9sEFXWEoeP
        X4Sa5Cjx48lBZpDrJAT4JG68FYTYzCcxadt0qDCvREebEES1msSGZRvYYHZ17VzJDGF7SNz+
        +Zh9AqPiLCS/zULyzywk/yxgZF7FKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmHRO/zv+
        ZQfjrj9JhxgFOBiVeHgrmBbGCLEmlhVX5h5ilOBgVhLhPdO/IEaINyWxsiq1KD++qDQntfgQ
        ozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QD41r3Kv6V8Z3XnvffrtVsf136mWUZS+eZ
        /A+lwiGSLI///9tT3DFbSX93+iz+h0zfJwZ8Oe3IbfN3sop01smlZ8Pmvv0VvWWL5rQn3vd3
        u3OlSQe/2N3+OKt04yah97Nf6R+vL71but7kg3nydD27h90c+1u+l22z6s6srTJxeqQgFpXw
        X+vkQiWW4oxEQy3mouJEALmwXnQ2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xe7omDItiDC5NN7Rof7eM3eLK1/ds
        FpseX2O1ONH3gdXi8q45bBbbNy9ktljxcyujA7vHvDXVHve7jzN5bF5S73Hnx1JGjyXTrrJ5
        fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+X
        oJfxs+M5W8FvpopFnUtYGhi3MXUxcnJICJhIfN29Bcjm4hASWMooMXnXcyCHAyghI3F8fRlE
        jbDEn2tdbBA1rxklli9exgiSEBYIkfj15DQLiC0iYCrR2rgLqmgao8Ts11sZQRxmgRuMEruv
        b2EDqWITsJKY2L4KrJtXwE5i/Z7tzCA2i4CKxMf/W8FqRAUiJG497GCBqBGUODnzCZjNKeAs
        sfBeG9jZzAJ6Ejuu/2KFsOUltr+dwzyBUXAWkpZZSMpmISlbwMi8ilEktbQ4Nz232FCvODG3
        uDQvXS85P3cTIzCath37uXkH46WNwYcYBTgYlXh4K5gWxgixJpYVV+YeYpTgYFYS4T3TvyBG
        iDclsbIqtSg/vqg0J7X4EKMp0BMTmaVEk/OBkZ5XEm9oamhuYWlobmxubGahJM573qAySkgg
        PbEkNTs1tSC1CKaPiYNTqoFR8uP5CD73W2Ez6xa1mypbJzTs6+WZZvvywbxXDCWaqyY/KP+y
        Srglo5DH5qbIxvKDvCeO1PYyPv+tZ9bmdoNhriaT7g6j3KVskn+Ons1gF2a+vbl6uQlP4YFF
        nDwaM/ZOvBSf+/fjwlMXmh9uPre38fKC564+1pWbuvmrNxxOUZ3ctTKhMU5eiaU4I9FQi7mo
        OBEAxE/BDbwCAAA=
X-CMS-MailID: 20190401121237eucas1p262ff4e0c45fe5fc6ea8831ea0371cf7c
X-Msg-Generator: CA
X-RootMTR: 20190225212603epcas3p42bd9d7e113c48af1fcb229ecccde2ebc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190225212603epcas3p42bd9d7e113c48af1fcb229ecccde2ebc
References: <CGME20190225212603epcas3p42bd9d7e113c48af1fcb229ecccde2ebc@epcas3p4.samsung.com>
        <20190225212533.26432-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/25/2019 10:25 PM, Alexandre Belloni wrote:
> Make the driver OF only as since AVR32 has been removed from the kernel,
> there are only OF enabled platform using it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
