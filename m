Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E71C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 04:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C93121479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 04:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fOg6vUJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfGAEOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 00:14:36 -0400
Received: from ozlabs.org ([203.11.71.1]:42217 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfGAEOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 00:14:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45cYt00YzYz9s4V;
        Mon,  1 Jul 2019 14:14:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561954472;
        bh=G/tCFqQumIeB98X+oAPxxzeuP/Ji3xklGnACIPGPhBw=;
        h=Date:From:To:Cc:Subject:From;
        b=fOg6vUJJrAxfsY35rhtC4vWP597Z2YhD0zht4DrO4OMu0kkJrXrJ1HXRQP1FmScKf
         lVxAVwxxmwcIBYjcXnLXIwq/QvOB7RSKXM82iMg9P+30vhhcqxti2wVYDxoVIu+sq7
         8QKhOY0DeZBW4KGozEmEJuUAMyNTP8KFYCvCIeduOhu5hP2jxCKxhYf8qJnttn7oTr
         /qsegM8jGqrTcpL1mr8hvC36jLyvr+muciIVe08C3pDsvqqFPxKL/qa0YSUjhW5KhJ
         C9AfMsYmoMkQ+RSPgm5frb6gq6o28cdlpQgAdW3SF56lGRvyBebGsnaUjlFnJvwjYi
         X1pK5v2Rdy8XA==
Date:   Mon, 1 Jul 2019 14:14:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xi Wang <wangxi11@huawei.com>, Lijun Ou <oulijun@huawei.com>
Subject: linux-next: build failure after merge of the rdma tree
Message-ID: <20190701141431.5cba95c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+FPGlPJ2GeCyfc/tbV3pq_G"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+FPGlPJ2GeCyfc/tbV3pq_G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (x86_64
allmodconfig) failed like this:

WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns=
_roce_ah.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns=
_roce_alloc.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns=
_roce_cmd.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns=
_roce_cq.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns=
_roce_db.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns=
_roce_hem.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns=
_roce_mr.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns=
_roce_pd.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns=
_roce_qp.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns=
_roce_restrack.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns=
_roce_srq.o
see include/linux/module.h for more information
ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_srq.ko=
] undefined!
ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_srq.ko] u=
ndefined!
ERROR: "hns_roce_free_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_srq.=
ko] undefined!
ERROR: "hns_roce_alloc_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_srq=
.ko] undefined!
ERROR: "hns_roce_table_get" [drivers/infiniband/hw/hns/hns_roce_srq.ko] und=
efined!
ERROR: "hns_roce_bitmap_alloc" [drivers/infiniband/hw/hns/hns_roce_srq.ko] =
undefined!
ERROR: "hns_roce_table_find" [drivers/infiniband/hw/hns/hns_roce_srq.ko] un=
defined!
ERROR: "hns_roce_ib_umem_write_mtt" [drivers/infiniband/hw/hns/hns_roce_srq=
.ko] undefined!
ERROR: "hns_roce_mtt_cleanup" [drivers/infiniband/hw/hns/hns_roce_srq.ko] u=
ndefined!
ERROR: "hns_roce_buf_write_mtt" [drivers/infiniband/hw/hns/hns_roce_srq.ko]=
 undefined!
ERROR: "hns_roce_buf_free" [drivers/infiniband/hw/hns/hns_roce_srq.ko] unde=
fined!
ERROR: "hns_roce_buf_alloc" [drivers/infiniband/hw/hns/hns_roce_srq.ko] und=
efined!
ERROR: "hns_roce_mtt_init" [drivers/infiniband/hw/hns/hns_roce_srq.ko] unde=
fined!
ERROR: "hns_roce_bitmap_free" [drivers/infiniband/hw/hns/hns_roce_srq.ko] u=
ndefined!
ERROR: "hns_roce_table_put" [drivers/infiniband/hw/hns/hns_roce_srq.ko] und=
efined!
ERROR: "hns_roce_cmd_mbox" [drivers/infiniband/hw/hns/hns_roce_srq.ko] unde=
fined!
ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_qp.ko]=
 undefined!
ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_qp.ko] un=
defined!
ERROR: "hns_roce_buf_free" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undef=
ined!
ERROR: "hns_roce_free_db" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undefi=
ned!
ERROR: "hns_roce_alloc_db" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undef=
ined!
ERROR: "hns_roce_bitmap_free_range" [drivers/infiniband/hw/hns/hns_roce_qp.=
ko] undefined!
ERROR: "hns_roce_bitmap_alloc_range" [drivers/infiniband/hw/hns/hns_roce_qp=
.ko] undefined!
ERROR: "hns_roce_db_unmap_user" [drivers/infiniband/hw/hns/hns_roce_qp.ko] =
undefined!
ERROR: "hns_roce_mtr_cleanup" [drivers/infiniband/hw/hns/hns_roce_qp.ko] un=
defined!
ERROR: "hns_roce_get_kmem_bufs" [drivers/infiniband/hw/hns/hns_roce_qp.ko] =
undefined!
ERROR: "hns_roce_buf_alloc" [drivers/infiniband/hw/hns/hns_roce_qp.ko] unde=
fined!
ERROR: "hns_roce_db_map_user" [drivers/infiniband/hw/hns/hns_roce_qp.ko] un=
defined!
ERROR: "hns_roce_free_buf_list" [drivers/infiniband/hw/hns/hns_roce_qp.ko] =
undefined!
ERROR: "hns_roce_table_get" [drivers/infiniband/hw/hns/hns_roce_qp.ko] unde=
fined!
ERROR: "hns_roce_mtr_attach" [drivers/infiniband/hw/hns/hns_roce_qp.ko] und=
efined!
ERROR: "hns_roce_mtr_init" [drivers/infiniband/hw/hns/hns_roce_qp.ko] undef=
ined!
ERROR: "hns_roce_hem_list_calc_root_ba" [drivers/infiniband/hw/hns/hns_roce=
_qp.ko] undefined!
ERROR: "hns_roce_get_umem_bufs" [drivers/infiniband/hw/hns/hns_roce_qp.ko] =
undefined!
ERROR: "hns_roce_alloc_buf_list" [drivers/infiniband/hw/hns/hns_roce_qp.ko]=
 undefined!
ERROR: "hns_roce_table_put" [drivers/infiniband/hw/hns/hns_roce_qp.ko] unde=
fined!
ERROR: "hns_roce_init_buf_region" [drivers/infiniband/hw/hns/hns_roce_qp.ko=
] undefined!
ERROR: "hns_roce_bitmap_free" [drivers/infiniband/hw/hns/hns_roce_pd.ko] un=
defined!
ERROR: "hns_roce_bitmap_alloc" [drivers/infiniband/hw/hns/hns_roce_pd.ko] u=
ndefined!
ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_pd.ko]=
 undefined!
ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_pd.ko] un=
defined!
ERROR: "hns_roce_hem_list_find_mtt" [drivers/infiniband/hw/hns/hns_roce_mr.=
ko] undefined!
ERROR: "hns_roce_hem_list_request" [drivers/infiniband/hw/hns/hns_roce_mr.k=
o] undefined!
ERROR: "hns_roce_hem_list_release" [drivers/infiniband/hw/hns/hns_roce_mr.k=
o] undefined!
ERROR: "hns_roce_hem_list_init" [drivers/infiniband/hw/hns/hns_roce_mr.ko] =
undefined!
ERROR: "hns_roce_check_whether_mhop" [drivers/infiniband/hw/hns/hns_roce_mr=
.ko] undefined!
ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_mr.ko]=
 undefined!
ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_mr.ko] un=
defined!
ERROR: "hns_roce_table_put_range" [drivers/infiniband/hw/hns/hns_roce_mr.ko=
] undefined!
ERROR: "hns_roce_table_get_range" [drivers/infiniband/hw/hns/hns_roce_mr.ko=
] undefined!
ERROR: "hns_roce_bitmap_alloc" [drivers/infiniband/hw/hns/hns_roce_mr.ko] u=
ndefined!
ERROR: "hns_roce_table_find" [drivers/infiniband/hw/hns/hns_roce_mr.ko] und=
efined!
ERROR: "hns_roce_bitmap_free" [drivers/infiniband/hw/hns/hns_roce_mr.ko] un=
defined!
ERROR: "hns_roce_table_put" [drivers/infiniband/hw/hns/hns_roce_mr.ko] unde=
fined!
ERROR: "hns_roce_free_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_mr.k=
o] undefined!
ERROR: "hns_roce_cmd_mbox" [drivers/infiniband/hw/hns/hns_roce_mr.ko] undef=
ined!
ERROR: "hns_roce_alloc_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_mr.=
ko] undefined!
ERROR: "hns_roce_table_get" [drivers/infiniband/hw/hns/hns_roce_mr.ko] unde=
fined!
ERROR: "hns_roce_fill_res_entry" [drivers/infiniband/hw/hns/hns_roce_main.k=
o] undefined!
ERROR: "hns_roce_dereg_mr" [drivers/infiniband/hw/hns/hns_roce_main.ko] und=
efined!
ERROR: "hns_roce_reg_user_mr" [drivers/infiniband/hw/hns/hns_roce_main.ko] =
undefined!
ERROR: "hns_roce_get_dma_mr" [drivers/infiniband/hw/hns/hns_roce_main.ko] u=
ndefined!
ERROR: "hns_roce_ib_destroy_cq" [drivers/infiniband/hw/hns/hns_roce_main.ko=
] undefined!
ERROR: "hns_roce_ib_create_cq" [drivers/infiniband/hw/hns/hns_roce_main.ko]=
 undefined!
ERROR: "hns_roce_modify_qp" [drivers/infiniband/hw/hns/hns_roce_main.ko] un=
defined!
ERROR: "hns_roce_create_qp" [drivers/infiniband/hw/hns/hns_roce_main.ko] un=
defined!
ERROR: "hns_roce_destroy_ah" [drivers/infiniband/hw/hns/hns_roce_main.ko] u=
ndefined!
ERROR: "hns_roce_query_ah" [drivers/infiniband/hw/hns/hns_roce_main.ko] und=
efined!
ERROR: "hns_roce_create_ah" [drivers/infiniband/hw/hns/hns_roce_main.ko] un=
defined!
ERROR: "hns_roce_dealloc_pd" [drivers/infiniband/hw/hns/hns_roce_main.ko] u=
ndefined!
ERROR: "hns_roce_alloc_pd" [drivers/infiniband/hw/hns/hns_roce_main.ko] und=
efined!
ERROR: "hns_roce_rereg_user_mr" [drivers/infiniband/hw/hns/hns_roce_main.ko=
] undefined!
ERROR: "hns_roce_dealloc_mw" [drivers/infiniband/hw/hns/hns_roce_main.ko] u=
ndefined!
ERROR: "hns_roce_alloc_mw" [drivers/infiniband/hw/hns/hns_roce_main.ko] und=
efined!
ERROR: "hns_roce_map_mr_sg" [drivers/infiniband/hw/hns/hns_roce_main.ko] un=
defined!
ERROR: "hns_roce_alloc_mr" [drivers/infiniband/hw/hns/hns_roce_main.ko] und=
efined!
ERROR: "hns_roce_destroy_srq" [drivers/infiniband/hw/hns/hns_roce_main.ko] =
undefined!
ERROR: "hns_roce_create_srq" [drivers/infiniband/hw/hns/hns_roce_main.ko] u=
ndefined!
ERROR: "hns_roce_cleanup_qp_table" [drivers/infiniband/hw/hns/hns_roce_main=
.ko] undefined!
ERROR: "hns_roce_cleanup_uar_table" [drivers/infiniband/hw/hns/hns_roce_mai=
n.ko] undefined!
ERROR: "hns_roce_cleanup_pd_table" [drivers/infiniband/hw/hns/hns_roce_main=
.ko] undefined!
ERROR: "hns_roce_cleanup_mr_table" [drivers/infiniband/hw/hns/hns_roce_main=
.ko] undefined!
ERROR: "hns_roce_cleanup_cq_table" [drivers/infiniband/hw/hns/hns_roce_main=
.ko] undefined!
ERROR: "hns_roce_cleanup_hem_table" [drivers/infiniband/hw/hns/hns_roce_mai=
n.ko] undefined!
ERROR: "hns_roce_cmd_use_polling" [drivers/infiniband/hw/hns/hns_roce_main.=
ko] undefined!
ERROR: "hns_roce_init_srq_table" [drivers/infiniband/hw/hns/hns_roce_main.k=
o] undefined!
ERROR: "hns_roce_cmd_cleanup" [drivers/infiniband/hw/hns/hns_roce_main.ko] =
undefined!
ERROR: "hns_roce_cleanup_hem" [drivers/infiniband/hw/hns/hns_roce_main.ko] =
undefined!
ERROR: "hns_roce_cleanup_bitmap" [drivers/infiniband/hw/hns/hns_roce_main.k=
o] undefined!
ERROR: "hns_roce_cmd_use_events" [drivers/infiniband/hw/hns/hns_roce_main.k=
o] undefined!
ERROR: "hns_roce_init_qp_table" [drivers/infiniband/hw/hns/hns_roce_main.ko=
] undefined!
ERROR: "hns_roce_init_cq_table" [drivers/infiniband/hw/hns/hns_roce_main.ko=
] undefined!
ERROR: "hns_roce_init_mr_table" [drivers/infiniband/hw/hns/hns_roce_main.ko=
] undefined!
ERROR: "hns_roce_init_pd_table" [drivers/infiniband/hw/hns/hns_roce_main.ko=
] undefined!
ERROR: "hns_roce_init_uar_table" [drivers/infiniband/hw/hns/hns_roce_main.k=
o] undefined!
ERROR: "hns_roce_check_whether_mhop" [drivers/infiniband/hw/hns/hns_roce_ma=
in.ko] undefined!
ERROR: "hns_roce_init_hem_table" [drivers/infiniband/hw/hns/hns_roce_main.k=
o] undefined!
ERROR: "hns_roce_cmd_init" [drivers/infiniband/hw/hns/hns_roce_main.ko] und=
efined!
ERROR: "hns_roce_uar_alloc" [drivers/infiniband/hw/hns/hns_roce_main.ko] un=
defined!
ERROR: "hns_roce_uar_free" [drivers/infiniband/hw/hns/hns_roce_main.ko] und=
efined!
ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_cq.ko]=
 undefined!
ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_cq.ko] un=
defined!
ERROR: "hns_roce_free_db" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undefi=
ned!
ERROR: "hns_roce_db_unmap_user" [drivers/infiniband/hw/hns/hns_roce_cq.ko] =
undefined!
ERROR: "hns_roce_buf_free" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undef=
ined!
ERROR: "hns_roce_mtt_cleanup" [drivers/infiniband/hw/hns/hns_roce_cq.ko] un=
defined!
ERROR: "hns_roce_ib_umem_write_mtt" [drivers/infiniband/hw/hns/hns_roce_cq.=
ko] undefined!
ERROR: "hns_roce_db_map_user" [drivers/infiniband/hw/hns/hns_roce_cq.ko] un=
defined!
ERROR: "hns_roce_buf_write_mtt" [drivers/infiniband/hw/hns/hns_roce_cq.ko] =
undefined!
ERROR: "hns_roce_buf_alloc" [drivers/infiniband/hw/hns/hns_roce_cq.ko] unde=
fined!
ERROR: "hns_roce_alloc_db" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undef=
ined!
ERROR: "hns_roce_mtt_init" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undef=
ined!
ERROR: "hns_roce_free_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_cq.k=
o] undefined!
ERROR: "hns_roce_alloc_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_cq.=
ko] undefined!
ERROR: "hns_roce_table_get" [drivers/infiniband/hw/hns/hns_roce_cq.ko] unde=
fined!
ERROR: "hns_roce_bitmap_alloc" [drivers/infiniband/hw/hns/hns_roce_cq.ko] u=
ndefined!
ERROR: "hns_roce_table_find" [drivers/infiniband/hw/hns/hns_roce_cq.ko] und=
efined!
ERROR: "hns_roce_check_whether_mhop" [drivers/infiniband/hw/hns/hns_roce_cq=
.ko] undefined!
ERROR: "hns_roce_bitmap_free" [drivers/infiniband/hw/hns/hns_roce_cq.ko] un=
defined!
ERROR: "hns_roce_table_put" [drivers/infiniband/hw/hns/hns_roce_cq.ko] unde=
fined!
ERROR: "hns_roce_cmd_mbox" [drivers/infiniband/hw/hns/hns_roce_cq.ko] undef=
ined!
ERROR: "hns_roce_cleanup_srq_table" [drivers/infiniband/hw/hns/hns_roce_all=
oc.ko] undefined!
ERROR: "hns_roce_cleanup_uar_table" [drivers/infiniband/hw/hns/hns_roce_all=
oc.ko] undefined!
ERROR: "hns_roce_cleanup_pd_table" [drivers/infiniband/hw/hns/hns_roce_allo=
c.ko] undefined!
ERROR: "hns_roce_cleanup_mr_table" [drivers/infiniband/hw/hns/hns_roce_allo=
c.ko] undefined!
ERROR: "hns_roce_cleanup_cq_table" [drivers/infiniband/hw/hns/hns_roce_allo=
c.ko] undefined!
ERROR: "hns_roce_cleanup_qp_table" [drivers/infiniband/hw/hns/hns_roce_allo=
c.ko] undefined!
ERROR: "to_hr_qp_type" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefi=
ned!
ERROR: "get_send_wqe" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefin=
ed!
ERROR: "hns_roce_release_range_qp" [drivers/infiniband/hw/hns/hns-roce-hw-v=
1.ko] undefined!
ERROR: "hns_roce_mtt_cleanup" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko]=
 undefined!
ERROR: "hns_roce_cmd_mbox" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] un=
defined!
ERROR: "hns_roce_cmd_event" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] u=
ndefined!
ERROR: "hns_roce_cq_completion" [drivers/infiniband/hw/hns/hns-roce-hw-v1.k=
o] undefined!
ERROR: "hns_roce_create_qp" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] u=
ndefined!
ERROR: "hns_roce_init" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefi=
ned!
ERROR: "hns_roce_buf_free" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] un=
defined!
ERROR: "hns_roce_free_cq" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] und=
efined!
ERROR: "hns_roce_hw2sw_mpt" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] u=
ndefined!
ERROR: "hns_get_gid_index" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] un=
defined!
ERROR: "hns_roce_dealloc_pd" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] =
undefined!
ERROR: "hns_roce_alloc_cmd_mailbox" [drivers/infiniband/hw/hns/hns-roce-hw-=
v1.ko] undefined!
ERROR: "hns_roce_qp_remove" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] u=
ndefined!
ERROR: "hns_roce_alloc_pd" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] un=
defined!
ERROR: "hns_roce_free_cmd_mailbox" [drivers/infiniband/hw/hns/hns-roce-hw-v=
1.ko] undefined!
ERROR: "get_recv_wqe" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefin=
ed!
ERROR: "hns_roce_unlock_cqs" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] =
undefined!
ERROR: "hns_roce_exit" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] undefi=
ned!
ERROR: "hns_roce_qp_event" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] un=
defined!
ERROR: "hns_roce_table_find" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] =
undefined!
ERROR: "to_hns_roce_state" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] un=
defined!
ERROR: "hns_roce_ib_create_cq" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko=
] undefined!
ERROR: "hns_roce_cq_event" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] un=
defined!
ERROR: "hns_roce_qp_free" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] und=
efined!
ERROR: "hns_roce_lock_cqs" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] un=
defined!
ERROR: "hns_roce_wq_overflow" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko]=
 undefined!
ERROR: "key_to_hw_index" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko] unde=
fined!
ERROR: "hns_roce_bitmap_free" [drivers/infiniband/hw/hns/hns-roce-hw-v1.ko]=
 undefined!
ERROR: "hns_roce_ib_destroy_cq" [drivers/infiniband/hw/hns/hns-roce-hw-v1.k=
o] undefined!

Presumably caused by commit

  e9816ddf2a33 ("RDMA/hns: Cleanup unnecessary exported symbols")

I have used the rdma tree from next-20190628 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/+FPGlPJ2GeCyfc/tbV3pq_G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ZiKcACgkQAVBC80lX
0GwVZAgAlfrtorIma4ZcC0O4p+KmPrgi5JbYPXvDXAExecdgHmXGD2lJmysPZVw9
T4sbf85cPB73IO0QuiHrkBzzklmlcQHjkmOMnbTkfrcjtfP8513Jyr9qEfPpKHWD
ZCvMEX0c1MCbmBh/zMsErD0JgFST1OneNcGpaKxZrz+nliIlXELXa2FNVQ0Dlf9j
8Rs8CdaaU6ctANCKNUk6dMOlzqo9zrJa/WFJy7T7F8mBgh2mmu4YfeNzCBpJYroC
mL3IN/VHpTxpCI+JR80q5vo3AACxlyvv5xTkFg9vB7WugYdUTZ+MkRg3jhO2n5pI
lSptwRSWgvlt6Vasoj40lo6wtbb5cA==
=vWFJ
-----END PGP SIGNATURE-----

--Sig_/+FPGlPJ2GeCyfc/tbV3pq_G--
